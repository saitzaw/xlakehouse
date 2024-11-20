# finops tech stack 
- Postgresql 
- DBT 
- Data Vault 2
- Star and Snowflake modeling

# project structure 
- create a folder in /home 
- mk ~/projects 
- create a fork folder for project 
- mk ~/projects/$NAME
- git clone in $HOME/projects/$NAME/
- create a virutal environemnt in that project folder. 
- create a docker file in this folder for advance test. 

# Installation steps  
- Prefer GNU/Linux or WSL 
- Install postgresql 
- then create database with user and password 
- create a database name as finops or related project name 
- create a schema flights and user as fin_ops_user
- Please use test and development in local enviroment first 
- Perfer GNU/Linux or WSL enviroment 
- create a project directory in /home or %USERPROFILE% 
- create a virtual environment for the Python 
- clone project in /home/project or %USERPROFILE%\project directory 
- create a .dbt folder in user directory in Windows, /home in GNU/Linux
- copy the profile.template and paste in .dbt/ in Linux or .dbt\ in windows
- run dbt init 
- run the dbt debug for testing database connection and dbt project

# Project component 
- staging 
- raw_vault 
- business_vault 
- Single view 
- data mart [Star or Snowflake]
- One big table [using json for repeat and duplicated data]

# Query optimization in this project
- using the cte for required columns 
- create temporary table 
- using archived data 
- using demornalization 
- join optimization

# Json format (postgresql)
table_name: my_address

|#| address::jsonb | 
|:-:|:------:|:---:|
|1| {street: '117 Shan Lan', township: 'Tamwe' } |
|2| {street: '160', township: 'Tamwe', city: 'Yangon'} |

```
select address->>'street' as street from my_address
```

# change data type in postgresql [if necessary]
```
ALTER TABLE database.flights.aircrafts
ALTER COLUMN model
SET DATA TYPE json
USING model::json;
```

# permission issue 
### check permission 
```
SELECT 
  grantee, 
  privilege_type 
FROM 
  information_schema.role_table_grants 
WHERE 
   table_name = 'boarding_passes' AND 
   table_schema = 'flights';
```

### if missing a read permission, run the following query
 GRANT SELECT ON flights.boarding_passes TO dbt_user;
 GRANT SELECT ON flights.tickets TO dbt_user;
 GRANT SELECT ON flights.tickets TO dbt_user;


### Scheduler and Data ochestration 
## create a postgresql user for airflow
- sudo -u postgres psql
- CREATE DATABASE airflow;
- CREATE USER airflow_user WITH ENCRYPTED PASSWORD 'airflow123';
- GRANT ALL PRIVILEGES ON DATABASE airflow TO airflow_user;

## Change airflow configuration
- change the airflow database connector in airflow.cfg
- sql_alchemy_conn = postgresql+psycopg2://airflow_user:airflow123@localhost:5432/airflow

# First time Run
## init the project
- airflow db init
- airflow users list

## create user
airflow users create \
    --username airflowAdmin \
    --firstname Airflow \
    --lastname Admin \
    --role Admin \
    --email airflow.admin@gmail.com

### create password 
create-password -> airflow123

## RUN AIRFLOW SERVER
airflow webserver --port 8090 -D
airflow scheduler -D

## Airflow
- run in default path /home/user/airflow
- create a soft link in dev environment for dags
- ln -s $HOME/projects/finops/dags $HOME/airflow/

