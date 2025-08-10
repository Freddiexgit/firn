{{ config(materialized='view') }}

select humidity , count(tripcount) hire_count from  {{ ref("weather_and_trip") }}  group by humidity