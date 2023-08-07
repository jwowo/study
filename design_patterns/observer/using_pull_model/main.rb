require_relative './weather_data'
require_relative './current_conditions_display'

weather_data = WeatherData.new
CurrentConditionsDisplay.new(weather_data)
weather_data.set_measurements(1, 2, 3)
weather_data.set_measurements(4, 5, 6)
