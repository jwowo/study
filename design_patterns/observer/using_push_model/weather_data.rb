# Subject class
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

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(temperature, humidity, pressure)
    end
  end
end
