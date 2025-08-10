{% macro to_celsius(fahrenheit_column, decimal_places=1) %}
  ROUND(({{ fahrenheit_column }} - 32) * 5/9, {{ decimal_places }})
{% endmacro %}