class CeilingFan
  HIGH = 3
  MEDIUM = 2
  LOW = 1
  OFF = 0

  def initialize(location)
    @location = location
    @speed = OFF
  end

  attr_reader :location
  attr_accessor :speed

  def high
    @speed = HIGH
    # 선풍기 속도를 HIGH로 맞추는 코드
    puts "#{location}의 선풍기 속도가 HIGH로 설정되었습니다"
  end

  def medium
    @speed = MEDIUM
    # 선풍기 속도를 MEDIUM로 맞추는 코드
    puts "#{location}의 선풍기 속도가 MEDIUM으로 설정되었습니다"
  end

  def low
    @speed = LOW
    # 선풍기 속도를 LOW로 맞추는 코드
    puts "#{location}의 선풍기 속도가 LOW로 설정되었습니다"
  end

  def off
    @speed = OFF
    # 선풍기를 끄는 코드
    puts "#{location}의 선풍기가 꺼졌습니다"
  end
end
