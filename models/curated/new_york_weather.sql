select
    new_york_weather:city.findname::string as name,
    new_york_weather:clouds.all::float as clouds,
    new_york_weather:main.humidity::float humidity,
    new_york_weather:main.pressure::float pressure,
    new_york_weather:main.temp::float temp,
    new_york_weather:main.temp_max::float temp_max,
    new_york_weather:main.temp_min::float temp_min,
    new_york_weather:time::timestamp time,
    weather.value:main::string weather,
    weather.value:description::string description,
    new_york_weather:wind.deg::float wind_degree,
    new_york_weather:wind.speed::float wind_speed

from
    bronze.new_york_weather_data,
    lateral flatten(input => new_york_weather:weather) as weather
