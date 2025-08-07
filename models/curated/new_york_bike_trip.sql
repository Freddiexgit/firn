SELECT 
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
    un_known,
    usertype,
    birth_year,
    gender,
    6371 * acos(
        cos(radians(start_station_lat))
        * cos(radians(end_station_lat))
        * cos(radians(end_station_lon) - radians(start_station_lon))
        + sin(radians(start_station_lat)) * sin(radians(end_station_lat))
    ) as trip_distance_km,
    current_timestamp as update_time 
from bronze.new_york_bike_trip