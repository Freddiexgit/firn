with
    tripcount as (
        select count(0) tripcount, t.starttime, t.stoptime
        from {{ ref("new_york_bike_trip") }}  t
        group by t.starttime, t.stoptime

    )

select
    w.clouds,
    w.humidity,
    w.pressure,
    w.temp,
    w.temp_max,
    w.temp_min,
    w.weather,
    w.wind_degree,
    w.wind_speed,
    t.tripcount
from {{ ref("new_york_weather") }} w
left join tripcount t on w.time between t.starttime and t.stoptime
