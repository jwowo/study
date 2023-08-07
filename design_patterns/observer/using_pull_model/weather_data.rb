class WeatherData
  def initialize
    @observers = []
  end

  attr_accessor :temperature, :humidity, :pressure

  def measurement_changed
    notify_observers
  end

  def set_measurements(temperature, humidity, pressure)
    @temperature = temperature
    @humidity = humidity
    @pressure = pressure
    measurement_changed
  end

  def add_observer(observer)
    @observers << observer
  end

  def notify_observers
    @observers.each(&:update)
  end
end
