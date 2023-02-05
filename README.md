# ETL Pipeline-bash-script
Using bash scripts to create data pipelines is incredibly useful as a data scientist

## Pre-requisites
docker installation

## Setting up the environment
we are going to work with docker containers

### Step 1:Launch a postgres container 

Launch a postgres container 

"docker run --name some-postgres -e POSTGRES_PASSWORD=mysecretpassword -p 5432:5432 -d postgres"

This command starts a PostgreSQL container named "some-postgres", sets the password for the PostgreSQL user "postgres" to "mysecretpassword", and publishes the PostgreSQL port (5432) to the host.

### Step 2: Start the Ubuntu container:
```
docker run --name some-ubuntu --link some-postgres:postgres -it ubuntu bash
```
This command starts an Ubuntu container named "some-ubuntu", links it to the PostgreSQL container "some-postgres" and gives it the alias "postgres", and launches the bash shell.

### step 3: Install the PostgreSQL client on the Ubuntu container:
```
apt-get update
apt-get install -y postgresql-client
apt-get install cron 
```

### step4: create the script.sh
![image](https://user-images.githubusercontent.com/89319105/215600375-8f24a4a5-2cdb-4b61-a3c3-99f6604e2829.png)

### step5: create table access_log
```
docker exec some-postgres psql -U postgres
```
```
\c template1;
CREATE TABLE access_log(timestamp TIMESTAMP, latitude float, longitude float, visitor_id char(37));
```
### step5 : run the script 
```
bash script.sh
```















