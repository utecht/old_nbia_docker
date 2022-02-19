## Running and initial user configuration

# Run
Use ./start.sh to bring up the non-tomcat containers first to give them time to populate


# Fix Bad Build
You need to copy a jar into one of the exploded wars to fix a problem

`docker compose exec tomcat bash`

`cp ./webapps/nbia-api/WEB-INF/lib/commons-collections-3.2.2.jar webapps/nbia-download/WEB-INF/lib/`

## Upload
`./insert_one_dicom.py`

http://localhost:8080/nbia-admin/ login as nbiaAdmin -> Perform Quality Check

Select your Public//Public, select the one file, set status to published, released to yes, and confirm as complete then Update.


## Fix bad database row
Connect to the mysql database and execute the following sql

`insert into study_series_number 
(patient_pk_id, patient_id, project, study_number, SERIES_NUMBER)
values
(98304, 'C3N-02523', 'Public', 1, 1)`

## Enjoy
http://localhost:8080/nbia-search