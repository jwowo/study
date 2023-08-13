require_relative 'pizza'

class NyCheesePizza < Pizza
  def initialize
    name = '뉴욕 스타일 소스와 치즈 피자'
    dough = '씬 크러스트 도우'
    sauce = '마리나라 소스'
    toppings = ['잘게 썬 레지아노 치즈']

    super(name, dough, sauce, toppings)
  end
end
