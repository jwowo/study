class Light
  def initialize(location)
    @location = location
  end

  attr_reader :location

  def on
    puts "#{location} 불이 켜졌습니다."
  end

  def off
    puts "#{location} 불이 꺼졌습니다."
  end
end
