require_relative 'command'

class LightOffCommand < Command
  def initialize(light)
    @light = light
  end

  attr_reader :light

  def execute
    light.off
  end

  def undo
    light.on
  end
end
