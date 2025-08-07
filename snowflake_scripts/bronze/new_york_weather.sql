use database citybike_db;
use schema bronze;

CREATE OR REPLACE STAGE new_york_weather
  URL = 's3://snowflake-workshop-lab/weather-nyc';

CREATE TABLE new_york_weather (
  new_york_weather VARIANT
);
COPY INTO new_york_weather
FROM @nyc_weather
FILE_FORMAT = (TYPE = 'JSON');

SELECT v
FROM new_york_weather
LIMIT 10;