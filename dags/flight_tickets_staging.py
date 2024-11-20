# import requirement 
import os 
from airflow import DAG
from airflow.utils.task_group import TaskGroup
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

# default project parth 
# in production it should read from environment variable 
# create a project folder for dags to run
PROJECT_STG_PATH = '$HOME/projects/finops/dags/includes'

# dag arguments 
default_args = {
    'owner': 'sthz',
    'start_date': datetime(2024, 11, 20),
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

# DAG 
with DAG(
    'flight_tickets_staging_data_upload',
    default_args = default_args,
    schedule_interval=timedelta(days=1)
) as dag:
    # to run the dbt tasks uing BashOperator 
    with TaskGroup(group_id='staging_flight_tickets') as stg_prj_flight_tickets:
        stg_sh_aircrafts = BashOperator(
            task_id = 'stg_aircrafts_dag',
            bash_command = f'{PROJECT_STG_PATH}/staging/stg_aircrafts.sh '
        )
        stg_sh_airports = BashOperator(
            task_id = 'stg_airports_dag',
            bash_command = f'{PROJECT_STG_PATH}/staging/stg_airports.sh '
        )
        stg_sh_airtickets = BashOperator(
            task_id = 'stg_airtickets_dag',
            bash_command = f'{PROJECT_STG_PATH}/staging/stg_airtickets.sh '
        )
        stg_sh_boarding_passes = BashOperator(
            task_id = 'stg_boarding_passes_dag',
            bash_command = f'{PROJECT_STG_PATH}/staging/stg_boarding_passes.sh '
        )
        stg_sh_bookings = BashOperator(
            task_id = 'stg_bookings_dag',
            bash_command = f'{PROJECT_STG_PATH}/staging/stg_bookings.sh '
        )
        stg_sh_flights = BashOperator(
            task_id = 'stg_flights_dag',
            bash_command = f'{PROJECT_STG_PATH}/staging/stg_flights.sh '
        )
        stg_sh_seats = BashOperator(
            task_id = 'stg_seats_dag',
            bash_command = f'{PROJECT_STG_PATH}/staging/stg_seats.sh '
        )
        stg_sh_ticket_flights = BashOperator(
            task_id = 'stg_ticket_flights_dag',
            bash_command = f'{PROJECT_STG_PATH}/staging/stg_ticket_flights.sh '
        )

        (
            stg_sh_aircrafts 
            >> stg_sh_airports 
            >> stg_sh_airtickets
            >> stg_sh_boarding_passes
            >> stg_sh_bookings
            >> stg_sh_flights
            >> stg_sh_seats
            >> stg_sh_ticket_flights
        )