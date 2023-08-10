require_relative '../pizza/cheese_pizza'

class SimplePizzaFactory
  def create_pizza(type)
    if type == 'cheese'
      pizza = CheesePizza.new
    elsif type == 'greek'
      pizza = GreekPizza.new
    elsif type == 'pepperoni'
      pizza = PepperoniPizza.new
    elsif type == 'clam'
      pizza = ClamPizza.new
    end

    pizza
  end
end
