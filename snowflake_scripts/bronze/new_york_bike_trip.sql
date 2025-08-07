use database citybike_db
use schema bronze
CREATE OR REPLACE FILE FORMAT csv_format
  TYPE = 'CSV'
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
  SKIP_HEADER = 0;



--  SELECT 
--   $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16
-- FROM @citibike_stage/japan/citibike-trips/trips_2013_0_5_0.csv.gz
-- --FILE_FORMAT = (FORMAT_NAME = 'csv_format_for_view')
-- LIMIT 10;



CREATE OR REPLACE STAGE new_york_bike_hire_stage
  URL = 's3://snowflake-workshop-lab/japan/citibike-trips/'
  FILE_FORMAT = csv_format;
  
LIST @citibike_stage;  


-- SELECT 
--   METADATA$FILENAME,
--   METADATA$FILE_ROW_NUMBER,
--   $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15, $16
-- FROM @citibike_stage
-- LIMIT 10;

-- SELECT * 
-- FROM TABLE(
--   INFER_SCHEMA(
--     LOCATION => '@citibike_stage',
--     FILE_FORMAT => 'csv_format'
--   )
-- )LIMIT 10;

-- COLUMN_NAME	TYPE	NULLABLE	EXPRESSION
-- c1	NUMBER(7, 0)	TRUE	$1::NUMBER(7, 0)
-- c2	TIMESTAMP_NTZ	TRUE	$2::TIMESTAMP_NTZ
-- c3	TIMESTAMP_NTZ	TRUE	$3::TIMESTAMP_NTZ
-- c4	NUMBER(4, 0)	TRUE	$4::NUMBER(4, 0)
-- c5	TEXT	TRUE	$5::TEXT
-- c6	NUMBER(11, 9)	TRUE	$6::NUMBER(11, 9)
-- c7	NUMBER(11, 9)	TRUE	$7::NUMBER(11, 9)
-- c8	TEXT	TRUE	$8::TEXT
-- c9	TEXT	TRUE	$9::TEXT
-- c10	TEXT	TRUE	$10::TEXT
-- c11	TEXT	TRUE	$11::TEXT
-- c12	NUMBER(5, 0)	TRUE	$12::NUMBER(5, 0)
-- c13	TEXT	TRUE	$13::TEXT
-- c14	TEXT	TRUE	$14::TEXT
-- c15	TEXT	TRUE	$15::TEXT
-- c16	NUMBER(1, 0)	TRUE	$16::NUMBER(1, 0)
CREATE OR REPLACE TABLE new_york_bike_trip (
  tripduration_inseconds STRING,
  starttime TIMESTAMP,
  stoptime TIMESTAMP,
  start_station_id STRING,
  start_station_name STRING,
  start_station_lat STRING,
  start_station_lon STRING,
  end_station_id STRING,
  end_station_name STRING,
  end_station_lat STRING,
  end_station_lon STRING,  
  bikeid STRING,
  un_known  STRING,
  usertype STRING,
  birth_year STRING,
  gender STRING
);


COPY INTO new_york_bike_trip
FROM @citibike_stage
FILE_FORMAT = (FORMAT_NAME = csv_format)
ON_ERROR = 'ABORT_STATEMENT';





------  count(0) > 0 means there are failed records 
-- SELECT count(0)
-- FROM TABLE(SNOWFLAKE.INFORMATION_SCHEMA.COPY_HISTORY('new_york_bike_trips', DATEADD(day, -1, CURRENT_TIMESTAMP())))
--  where error_count >  0
--  and last_load_time >=  (SELECT START_TIME
-- FROM TABLE(SNOWFLAKE.INFORMATION_SCHEMA.QUERY_HISTORY())
-- where query_text like 'COPY INTO new_york_bike_trip%'
-- ORDER BY START_TIME DESC
-- LIMIT 1);
 



select * from new_york_bike_trip limit 10 
 
