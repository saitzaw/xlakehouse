# https://github.com/irtiza07/postgres_debezium_cdc
## postgresql
- check the running docker images 
```Shell 
docker ps 
```

## login to the interactive shell via host cli 
```Shell 
docker exec -it 123456678 /bin/bash 
```
### Get the postgre 

```Shell 
psql -U docker -d exampledb -W
docker 
```

#### to Run the debezium 
# initial 
```SHELL
curl -i -X POST -H "Accept:application/json" -H "Content-Type:application/json" 127.0.0.1:8083/connectors/ --data "@debezium.json"
```

# check status 
```SHELL 
curl http://127.0.0.1:8083/connectors/exampledb-connector/status
```
# update the status 
```SHELL
curl -i -X PUT -H "Accept:application/json" -H "Content-Type:application/json" http://127.0.0.1:8083/connectors/exampledb-connector/config --data "@debezium.json"
```
## Kafka 
### RUN topic 
```SHELL 
docker run --tty \
--network postgres_debezium_cdc_default \
confluentinc/cp-kafkacat \
kafkacat -b kafka:9092 -C \
-s key=s -s value=avro \
-r http://schema-registry:8081 \
-t postgres.public.customers
```


### RUN topic [Group]
```SHELL 
docker run --tty \
--network postgres_debezium_cdc_default \
confluentinc/cp-kafkacat \
kafkacat -b kafka:9092 -G my-consumer-group postgres.public.customers
```

# RUN topic 
```SHELL
docker run --tty \
--network postgres_debezium_cdc_default \
confluentinc/cp-kafkacat \
kafkacat -b kafka:9092 -C \
-s key=s -s value=avro \
-r http://schema-registry:8081 \
-t postgres.public.customers
```


```SHELL
docker run --tty \
--network postgres_debezium_cdc_default \
confluentinc/cp-kafkacat \
kafkacat -b kafka:9092 -C \
-s key=s -s value=avro \
-r http://schema-registry:8081 \
-t postgres.public.orders
```

## Kakfa UI 
localhost:8085

### create a test table 

```SHELL 
-- Create Customers Table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert Dummy Customers
INSERT INTO customers (name, email) VALUES
    ('Alice Johnson', 'alice@example.com'),
    ('Bob Smith', 'bob@example.com'),
    ('Charlie Brown', 'charlie@example.com');


-- insert another record 
INSERT INTO customers (name, email) VALUES
    ('Doe White', 'doe@example.com'); 

-- update record 
UPDATE customers SET email = 'charliebrown@gmail.com' WHERE name = 'Bob Smith'; 


-- new insert 
INSERT INTO customers (name, email) VALUES
    ('Fannia Johnson', 'fannia@example.com'),
    ('Ethan Sith', 'ethan@example.com'),
    ('Gorge Bush', 'gorge@example.com');

-- update record
UPDATE customers SET email = 'gorgebush@outlook.com' WHERE name = 'Gorge Bush'; 

-- delete record 
DELETE FROM customer WHERE name = 'Ethan Sith'; 

-- new recrod 
INSERT INTO customers (name, email) VALUES
    ('Henry Johnson', 'henry@example.com'),
    ('Ivan Nov', 'ivan@example.com'),
    ('Joesept Gog', 'joe@example.com');


-- new record 
INSERT INTO customers (name, email) VALUES
    ('Kelly Johnson', 'kelly@example.com'),
    ('Linux trovad', 'linux@example.com'),
    ('Mongessues tipso', 'mongessues@example.com');


-- Create Orders Table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    product_name TEXT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- Insert Dummy Orders
INSERT INTO orders (customer_id, product_name, quantity, price) VALUES
    (1, 'Laptop', 1, 1200.00),
    (2, 'Smartphone', 2, 800.00),
    (3, 'Headphones', 1, 150.00);

```

### Debuging 

## format checker 
```shell 
docker exec -it e6aecf78838e kafka-console-consumer \
  --bootstrap-server kafka:9092 \
  --topic postgres.public.customers --from-beginning
```

## format check 
```shell 
docker exec -it 79ae939345ee kafka-console-consumer \
  --bootstrap-server kafka:9092 \
  --topic postgres.public.customers \
  --from-beginning \
  --property print.key=true \
  --property print.value=true

```

## to check the kafka streaming from start 
```shell
docker exec -it 6e6ee3767d43 \
kafka-console-consumer --bootstrap-server localhost:9092 \
--topic postgres.public.customers --from-beginning
```

## to check the data is actually create or not 
```shell 
docker exec -it 6e6ee3767d43 \
kafka-topics --bootstrap-server localhost:9092 --list

```

## check the value format 
```shell 
docker exec -it 79ae939345ee kafka-console-consumer \
  --bootstrap-server kafka:9092 \
  --topic postgres.public.customers \
  --from-beginning \
  --property print.key=true \
  --property print.value=true

```

## check debezium connection 
```shell 

curl -X GET http://localhost:8083/connectors/exampledb-connector/config

```

## check kakfa offect 
``` shell 
docker exec -it 6e6ee3767d43 \
kafka-run-class kafka.tools.GetOffsetShell --broker-list kafka:9092 --topic postgres.public.customers --time -1
```

### check the docker networks 
```shell 
 docker network ls
```


### inspect docker network 
```shell 
docker network inspect postgres_debezium_cdc_default
```

docker exec -it your-kafka-broker-container-name /bin/bash

kafka-console-consumer --bootstrap-server localhost:9092 --topic my-topic --from-beginning

## spark session for kakfa 
- 'spark.streaming.stopGracefullyOnShutdown', True
- 'spark.jars.packages', 'org.apache.spark:spark-sql-kafka-0-10_2.12:3.3.0' 
- 'spark.sql.shuffle.partitions' 

## udpdate the debezium 
```shell 
curl -X DELETE http://localhost:8083/connectors/exampledb-connector
curl -X POST -H "Content-Type: application/json" --data @debezium.json http://localhost:8083/connectors
```

### Spark structure streaming config 
