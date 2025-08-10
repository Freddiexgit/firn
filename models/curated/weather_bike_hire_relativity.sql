{{ config(materialized='view') }}

select weather , count(tripcount) hire_count from  {{ ref("weather_and_trip") }}  group by weather