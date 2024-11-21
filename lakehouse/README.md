### Combination of data lake and data warehouse 
- Apache Spark 
- Unity Catalog 
- Delta Table
- One Bigtable 

### Ingest data 
- Ingest data from csv and other file format 
- Ingest data from various databases 

### Architecture 
- Bronze 
    - Data collection and staging layer
    - Integration layer with streaming data
    - Nothing to do
- Silver 
    - Mixed usage of Warehouse and Lake
        - for old system 
            - provide data to Data Vault that is working in Postgresql
         - for new system 
            -  provide data to file system [Delta table]
    - Business logic are adding at business vault 
- Gold 
    - using wellknow Kimball's architecture 
    - data as file as well as in table
