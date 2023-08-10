require_relative 'simple_pizza_factory'

class PizzaStore
  def initialize(factory)
    @factory = factory
  end

  attr_reader :factory

  def order_pizza(type)
    pizza = factory.create_pizza(type)

    pizza.prepare
    pizza.bake
    pizza.cut
    pizza.box
    pizza
  end
end
