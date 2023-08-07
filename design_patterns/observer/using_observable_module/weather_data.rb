require 'observer'

class WeatherData
  include Observable

  def initialize; end

  attr_accessor :temperature, :humidity, :pressure

  def measurement_changed
    changed
    notify_observers(temperature, humidity)
  end

  def set_measurements(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    measurement_changed
  end
end
