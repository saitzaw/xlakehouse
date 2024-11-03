#!/bin/bash

dbt seed --select seeds/aircrafts.csv
dbt seed --select seeds/airports.csv
dbt seed --select seeds/boarding_passes.csv
dbt seed --select seeds/bookings.csv
dbt seed --select seeds/seats.csv


