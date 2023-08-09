class CondimentDecorator
  def initialize(beverage)
    @beverage = beverage
  end

  attr_reader :beverage
end
