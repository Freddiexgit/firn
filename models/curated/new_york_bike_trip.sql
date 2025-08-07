SELECT 

tripduration_inseconds ,
  starttime ,
  stoptime ,
  start_station_id ,
  start_station_name ,
  start_station_lat ,
  start_station_lon ,
  end_station_id ,
  end_station_name ,
  end_station_lat ,
  end_station_lon ,  
  bikeid ,
  un_known  ,
  usertype ,
  birth_year ,
  gender ,
  6371 * ACOS(
    COS(RADIANS(start_station_lat)) * COS(RADIANS(end_station_lat)) *
    COS(RADIANS(end_station_lon) - RADIANS(start_station_lon)) +
    SIN(RADIANS(start_station_lat)) * SIN(RADIANS(end_station_lat))
  ) AS trip_distance_km,
  update_time  CURRENT_TIMESTAMP
from {{ source("bronze", "new_york_bike_trip") }}