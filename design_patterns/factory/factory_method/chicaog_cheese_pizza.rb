require_relative 'pizza'

class ChicaogCheesePizza < Pizza
  def initialize
    name = '시카고 스타일 딥 디쉬 치즈 피자'
    dough = '아주 두꺼운 크러스트 도우'
    sauce = '플럼 토마토 소스'
    toppings = ['잘게 조각낸 모짜렐라 치즈']

    super(name, dough, sauce, toppings)
  end

  def cut
    puts '네모난 모양으로 피자 자르기'
  end
end
