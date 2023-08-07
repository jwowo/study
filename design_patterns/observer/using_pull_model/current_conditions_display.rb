class CurrentConditionsDisplay
  def initialize(weather_data)
    @weather_data = weather_data
    weather_data.add_observer(self)
  end

  attr_accessor = :temperature, :humidity, :weather_data

  def update
    @temperature = @weather_data.temperature
    @humidity = @weather_data.humidity
    display
  end

  def display
    puts "현재 상태: 온도 #{@temperature}, 습도 #{@humidity} "
  end
end
