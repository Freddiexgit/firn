{{ config(materialized='view') }}
select wind_degree, wind_speed , count(tripcount) hire_count from  {{ ref("weather_and_trip") }}  group by wind_degree, wind_speed 