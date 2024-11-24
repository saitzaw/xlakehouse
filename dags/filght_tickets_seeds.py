# import required modules
from airflow import DAG
from airflow.operators.bash_operator import BashOperator
from datetime import datetime, timedelta

# Seed path 
PROJECT_SEED_PATH = '$HOME/projects/xlakehouse/dags/includes'

# default dag arguments 
default_args = {
    'owner': 'sthz',
    'start_date': datetime(2024, 11, 21),
    'retries': 1,
    'retry_delay': timedelta(minutes=5)
}

# DAG HERE 
with DAG(
    'flight_ticket_data_seeding',
    default_args = default_args,
    schedule_interval=timedelta(days=1)
) as dag:
    seed_aircrafts = BashOperator(
        task_id = 'seed_aircraft_dag',
        bash_command = f'{PROJECT_SEED_PATH}/seed_flight_tickets/seed_aircrafts.sh '
    )
    seed_airports =  BashOperator(
        task_id = 'seed_airports_dag',
        bash_command = f'{PROJECT_SEED_PATH}/seed_flight_tickets/seed_airports.sh '
    )

    seed_boarding_passes =  BashOperator(
        task_id = 'seed_boarding_passes_dag',
        bash_command = f'{PROJECT_SEED_PATH}/seed_flight_tickets/seed_boarding_passes.sh '
    )

    seed_bookings =  BashOperator(
        task_id = 'seed_bookings_dag',
        bash_command = f'{PROJECT_SEED_PATH}/seed_flight_tickets/seed_bookings.sh '
    )

    seed_seats =  BashOperator(
        task_id = 'seed_seats_dag',
        bash_command = f'{PROJECT_SEED_PATH}/seed_flight_tickets/seed_seats.sh '
    )
