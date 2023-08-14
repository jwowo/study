require_relative 'pizza_store'
require_relative 'ny_pizza_ingredient_factory'
require_relative 'cheese_pizza'

class NyPizzaStore < PizzaStore
  def create_pizza(item)
    pizza_ingredient_factory = NyPizzaIngredientFactory.new

    case item
    when 'cheese'
      pizza = CheesePizza.new(pizza_ingredient_factory)
      pizza.name = '뉴욕 스타일 치즈 피자'
    when 'pepperoni'
      pizza = PepperoniPizza.new(pizza_ingredient_factory)
      pizza.name = '뉴욕 스타일 페퍼로니 피자'
    when 'clam'
      pizza = ClamPizza.new(pizza_ingredient_factory)
      pizza.name = '뉴욕 스타일 조개 피자'
    when 'veggie'
      pizza = VeggiePizza.new(pizza_ingredient_factory)
      pizza.name = '뉴욕 스타일 야채 피자'
    end

    pizza
  end
end
