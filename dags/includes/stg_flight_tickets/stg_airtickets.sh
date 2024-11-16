#!/bin/bash 

MY_PATH=$HOME/projects/finops
MY_SRC_FOLDER=$MY_PATH/flight_tickets

# check the project is located in 
if [ -d $MY_PATH ]; then 
    cd $MY_PATH
    source .dbt-1.8.8/bin/activate 
    if [ $VIRTUAL_ENV != "" ]; then
         cd $MY_SRC_FOLDER
         dbt run --select models/staging/stg_airtickets.sql
         deactivate
    else 
        echo "VIRTUAL ENVRIONMENT CANNOT BE ACTIVATED: check in $MY_PATH" 
    fi 
else
    echo "CANNOT FIND THE LOCATION: $MY_PATH is not found" 
fi 





