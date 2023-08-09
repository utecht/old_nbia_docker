#!/usr/bin/env python3 -u

import json
import time
import os
from typing import NamedTuple

import requests

URL = "http://localhost:8080"
USER = "nbiaAdmin"
PASS = "admin"
CLIENTID = "nbiaRestAPIClient"
CLIENTSECRET = "ItsBetweenUAndMe"
RETRY_COUNT = 1

TOKEN = None


class LoginFailedError(RuntimeError):
    pass


class LoginExpiredError(RuntimeError):
    pass


class SubmitFailedError(RuntimeError):
    pass


class File(NamedTuple):
    subprocess_invocation_id: int
    file_id: int
    collection: str
    site: str
    site_id: int
    batch: int
    filename: str
    third_party_analysis_url: str


def send_one(file_name):
    file = File(
        subprocess_invocation_id=0,  # does not matter
        file_id=141703361,  # does not matter
        collection="Col",
        site="Site",
        site_id=23153719,
        batch=5247,  # does not matter
        filename="/opt/dicoms/{}".format(file_name),
        third_party_analysis_url=None,  # does not matter
    )
    try:
        _submit_file(file)
    except SubmitFailedError as e:
        # probably should put this onto a failed-file list now?
        print(e)


def submit_file(f):
    """Submit the file, try several times before giving up"""
    global TOKEN

    errors = []
    for i in range(RETRY_COUNT):
        try:
            return _submit_file(f)
        except SubmitFailedError as e:
            errors.append(e)
        except requests.exceptions.ConnectionError as e:
            errors.append(e)
            print("WAIT: Server rejected connection, waiting 1 second for retry...")
            time.sleep(1)  # wait a bit for the server to get over it's funk
        except LoginExpiredError:
            TOKEN = login_to_api()

    raise SubmitFailedError(
        ("Failed to submit the file; error details follow", f, errors)
    )


def _submit_file(f):
    tpa_url = f.third_party_analysis_url

    if tpa_url is None:
        tpa_url = ""

    if len(tpa_url) > 0:
        tpa = "yes"
    else:
        tpa = "NO"

    payload = {
        "project": f.collection,
        "siteName": f.site,
        "siteID": f.site_id,
        "batch": f.batch,
        "uri": f.filename,
        "thirdPartyAnalysis": tpa,
        "descriptionURI": tpa_url,
    }
    headers = {
        "Authorization": "Bearer {}".format(TOKEN),
    }
    req = requests.post(
        URL + "/nbia-api/services/submitDICOM", headers=headers, data=payload
    )

    if req.status_code == 200:
        print(f.filename)
        return
    elif req.status_code == 401:
        # indicates an acess error, generally an expired token
        message = req.json()
        if message["error"] == "invalid_token":
            raise LoginExpiredError()
        else:
            raise SubmitFailedError(req.content)
    else:
        raise SubmitFailedError((req.status_code, req.content))


def login_to_api():
    payload = {
        "username": USER,
        "password": PASS,
        "client_id": CLIENTID,
        "client_secret": CLIENTSECRET,
        "grant_type": "password",
    }
    req = requests.post(URL + "/nbia-api/oauth/token", data=payload)

    if req.status_code == 200:
        obj = req.json()
        return obj["access_token"]
    else:
        raise LoginFailedError(req.content)


def login_or_die():
    for i in range(10):
        try:
            return login_to_api()
        except LoginFailedError as e:
            print(e)
            time.sleep(1)

    raise LoginFailedError("Login failed too many times, see previous errors!")


def main():
    global TOKEN

    print("ream, starting up...")

    TOKEN = login_or_die()
    print(f"logged in to api, token={TOKEN}")

    # main_loop()
    dicoms = [
        "090.dcm",
    ]
    dicoms = os.listdir("dicoms")
    for dicom in dicoms:
        send_one(dicom)


if __name__ == "__main__":
    main()
