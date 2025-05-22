CREATE EXTERNAL TABLE iot_analytics.total_usage_by_region (
  region STRING,
  total_usage DOUBLE
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'field.delim' = ',',
  'serialization.format' = ','
)
STORED AS TEXTFILE
LOCATION 's3://iot-usage-analyzer/processed/total_usage_by_region/'
TBLPROPERTIES ('skip.header.line.count'='1');
----

CREATE EXTERNAL TABLE iot_analytics.daily_usage_by_region (
    usage_date  date,
    total_usage DOUBLE,
    region STRING
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES
(
 'field.delim' = ',',
 'serialization.format'=','
)
STORED AS TEXTFILE
LOCATION 's3://iot-usage-analyzer/processed/daily_usage_by_region/'
TBLPROPERTIES ('skip.header.line.count'= '1');
----
CREATE EXTERNAL TABLE iot_analytics.top_users_per_region(
    household_id STRING,
    owner_name STRING,
    region STRING,
    total_usage DOUBLE,
    rank_in_region  integer
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
  'field.delim' = ',',
  'serialization.format' = ','
)
STORED AS TEXTFILE
LOCATION 's3://iot-usage-analyzer/processed/top_users_per_region/'
TBLPROPERTIES ('skip.header.line.count'='1');

CREATE EXTERNAL TABLE iot_analytics.total_usage_by_household(
    household_id    STRING,
    owner_name  STRING,
    region STRING,
    total_usage DOUBLE
)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
WITH SERDEPROPERTIES (
 'field.delim' = ',',
 'serialization.format' = ','
)
STORED AS TEXTFILE 
LOCATION 's3://iot-usage-analyzer/processed/total_usage_by_household/'
TBLPROPERTIES ('skip.header.line.count'='1')
;


--- PARQUET TABLES

CREATE TABLE iot_analytics.daily_usage_by_region_parquet 
WITH (
        format = 'PARQUET',
        external_location = 's3://iot-usage-analyzer/parquet/daily_usage_by_region/',
        write_compression = 'SNAPPY'
)
AS 
SELECT * FROM iot_analytics.daily_usage_by_region;

CREATE TABLE iot_analytics.top_users_per_region_parquet 
WITH (
        format = 'PARQUET',
        external_location = 's3://iot-usage-analyzer/parquet/top_users_per_region/',
        write_compression = 'SNAPPY'
)
AS
SELECT * FROM top_users_per_region;

CREATE TABLE iot_analytics.total_usage_by_household_parquet
WITH (
        format = 'PARQUET',
        external_location = 's3://iot-usage-analyzer/parquet/total_usage_by_household/',
        write_compression = 'SNAPPY'
)
AS
SELECT * FROM total_usage_by_household;

CREATE TABLE iot_analytics.total_usage_by_region_parquet
WITH (
        format = 'PARQUET',
        external_location = 's3://iot-usage-analyzer/parquet/total_usage_by_region/',
        write_compression = 'SNAPPY'
)
AS
SELECT * FROM total_usage_by_region;