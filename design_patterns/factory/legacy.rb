# 팩토리 패턴 적용 전 코드
require_relative './pizza/cheese_pizza'

def order_pizza(type)
  if type == 'cheese'
    pizza = CheesePizza.new
  elsif type == 'greek'
    pizza = GreekPizza.new
  elsif type == 'pepperoni'
    pizza = PepperoniPizza.new
  elsif type == 'clam'
    pizza = ClamPizza.new
  end

  pizza.prepare
  pizza.bake
  pizza.cut
  pizza.box
  pizza
end

pizza = order_pizza('cheese')
