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
  usertype ,
  birth_year ,
  gender ,
  acos_input ,
 6371 * ACOS(LEAST(1, GREATEST(-1,acos_input)))  AS trip_distance_km,
  CURRENT_TIMESTAMP as update_time  
  from (
SELECT *,
  COS(RADIANS(TO_DOUBLE(start_station_lat))) * COS(RADIANS(TO_DOUBLE(end_station_lat))) *
  COS(RADIANS(TO_DOUBLE(end_station_lon)) - RADIANS(TO_DOUBLE(start_station_lon))) +
  SIN(RADIANS(TO_DOUBLE(start_station_lat))) * SIN(RADIANS(TO_DOUBLE(end_station_lat))) AS acos_input
FROM bronze.new_york_bike_trip
WHERE start_station_lat <> ''
  AND start_station_lon <> ''
  AND end_station_lat <> ''
  AND end_station_lon <> ''
) 