require_relative './turkey'

class WildTurkey < Turkey
  def gobble
    puts '골골'
  end

  def fly
    puts '짧은 거리를 날고 있어요'
  end
end
