with
    bike_ride_no_invalid_co as (
        select
            *,
            cos(radians(to_double(start_station_lat)))
            * cos(radians(to_double(end_station_lat)))
            * cos(
                radians(to_double(end_station_lon))
                - radians(to_double(start_station_lon))
            )
            + sin(radians(to_double(start_station_lat)))
            * sin(radians(to_double(end_station_lat))) as acos_input
        from {{ source("bronze", "new_york_bike_trip") }}
        where
            start_station_lat <> ''
            and start_station_lon <> ''
            and end_station_lat <> ''
            and end_station_lon <> ''
    )

select
    tripduration_inseconds,
    starttime,
    stoptime,
    start_station_id,
    start_station_name,
    start_station_lat,
    start_station_lon,
    end_station_id,
    end_station_name,
    end_station_lat,
    end_station_lon,
    bikeid,
    usertype,
    birth_year,
    gender,
    acos_input,
    6371 * acos(least(1, greatest(-1, acos_input))) as trip_distance_km,
    current_timestamp as update_time
from bike_ride_no_invalid_co
