require_relative 'pizza_store'
require_relative 'ny_cheese_pizza'

class NyPizzaStore < PizzaStore
  def create_pizza(item)
    case item
    when 'cheese'
      NyCheesePizza.new
    when 'pepperoni'
      NyPepperoniPizza.new
    when 'clam'
      NyClamPizza.new
    when 'veggi'
      NyVeggiePizza.new
    end
  end
end
