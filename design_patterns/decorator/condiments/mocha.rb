require_relative 'condiment_decorator'

class Mocha < CondimentDecorator
  def initialize(beverage)
    super(beverage)
  end

  def description
    "#{beverage.description}, 모카"
  end

  def cost
    beverage.cost + 0.20
  end
end
