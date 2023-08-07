require_relative './weather_data'
require_relative './current_conditions_display'

weather_data = WeatherData.new
current_conditions_display = CurrentConditionsDisplay.new(10, 11)
current_conditions_display.display
weather_data.add_observer(current_conditions_display)
weather_data.set_measurements(19, 20, 21)
