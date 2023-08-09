require_relative 'condiment_decorator'

class Soy < CondimentDecorator
  def initialize(beverage)
    super(beverage)
  end

  def description
    "#{beverage.description}, 두유"
  end

  def cost
    beverage.cost + 0.35
  end
end
