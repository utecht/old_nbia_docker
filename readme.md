## Running and initial user configuration

# Run
Use ./start.sh to bring up the non-tomcat containers first to give them time to populate


# Fix Bad Build
You need to copy a jar into one of the exploded wars to fix a problem

`docker compose exec tomcat bash`

`cp ./webapps/nbia-api/WEB-INF/lib/commons-collections-3.2.2.jar webapps/nbia-download/WEB-INF/lib/`

# Restart nbia-download
http://localhost:8080/manager/html login with joseph/example and start nbia-download/

# Create collection and assign roles
http://localhost:8080/nbia-search/

Click through errors and then login as nbiaAdmin/admin
Click User Admin at top

Protection Element->Add Protection Element
`collection->test_collection // site->test_site`

Refresh, assign both protection groups to newly created protection element.

User Authorization w/ PG

Select nbiaAdmin from dropdown in top left, add protection group NCIA.Common_PG with all roles

http://localhost:8080/manager/html reload nbia-api/

## Upload
`./insert_one_dicom.py`

http://localhost:8080/nbia-admin/ login as nbiaAdmin -> Perform Quality Check

Select your test_collection//test_site, select the one file, set status to published, released to yes, and confirm as complete then Update.


## Fix bad database row
Connect to the mysql database and execute the following sql

`insert into study_series_number 
(patient_pk_id, patient_id, project, study_number, SERIES_NUMBER)
values
(98304, 'C3N-02523', 'test_collection', 1, 1)`

## Enjoy
http://localhost:8080/nbia-search