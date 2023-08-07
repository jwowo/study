class CurrentConditionsDisplay
  def initialize(temperature, humidity)
    @temperature = temperature
    @humidity = humidity
  end

  attr_accessor = :temperature, :humidity

  def update(temperature, humidity)
    @temperature = temperature
    @humidity = humidity
    display
  end

  def display
    puts "현재 상태: 온도 #{@temperature}, 습도 #{@humidity} "
  end
end
