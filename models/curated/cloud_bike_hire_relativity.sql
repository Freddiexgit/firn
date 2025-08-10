{{ config(materialized='view') }}

select clouds , count(tripcount) hire_count from  {{ ref("weather_and_trip") }}  group by clouds