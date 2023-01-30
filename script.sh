# cp-access-log.sh
# This script downloads the file 'web-server-access-log.txt.gz'
# from "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/".

# The script then extracts the .txt file using gunzip.

# The .txt file contains the timestamp, latitude, longitude 
# and visitor id apart from other data.

# Transforms the text delimeter from "#" to "," and saves to a csv file.
# Loads the data from the CSV file into the table 'access_log' in PostgreSQL database.

# Download the access log file
# Download the access log file

wget "https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBM-DB0250EN-SkillsNetwork/labs/Bash%20Scripting/ETL%20using%20shell%20scripting/web-server-access-log.txt.gz"

#Unzip the gzip file
# Unzip the file to extract the .txt file.
gunzip -f web-server-access-log.txt.gz

#Extract required fields from the file.

# Extract phase
echo "Extracting data"
# Extract the columns 1 (timestamp), 2 (latitude), 3 (longitude) and 
# 4 (visitorid)
cut -d"#" -f1-4  web-server-access-log.txt > extracted-data.txt

tr "#" "," <extracted-data.txt> transformed-data.csv


#Load the data into the table access_log in PostgreSQL

echo "\c template1; \COPY access_log FROM '/transformed-data.csv' DELIMITERS ',' CSV HEADER; " | psql -h postgres -U postgres
#Verify by querying the database.

echo '\c template1; \\SELECT * from access_log;' | psql -h postgres -U postgres