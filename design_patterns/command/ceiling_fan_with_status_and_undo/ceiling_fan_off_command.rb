require_relative 'command'

class CeilingFanOffCommand < Command
  def initialize(ceiling_fan)
    @ceiling_fan = ceiling_fan
  end

  attr_reader :ceiling_fan
  attr_accessor :prev_speed

  def execute
    @prev_speed = ceiling_fan.speed
    ceiling_fan.off
  end

  def undo
    case prev_speed
    when CeilingFan::HIGH
      ceiling_fan.high
    when CeilingFan::MEDIUM
      ceiling_fan.medium
    when CeilingFan::LOW
      ceiling_fan.low
    else
      ceiling_fan.off
    end
  end
end
