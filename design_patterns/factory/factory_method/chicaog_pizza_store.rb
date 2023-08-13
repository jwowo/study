require_relative 'pizza_store'
require_relative 'chicaog_cheese_pizza'

class ChicaogPizzaStore < PizzaStore
  def create_pizza(item)
    case item
    when 'cheese'
      ChicaogCheesePizza.new
    when 'pepperoni'
      ChicaogPepperoniPizza.new
    when 'clam'
      ChicaogClamPizza.new
    when 'veggi'
      ChicaogVeggiePizza.new
    end
  end
end
