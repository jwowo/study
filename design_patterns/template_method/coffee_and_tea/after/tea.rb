require_relative 'caffeine_beverage'

class Tea < CaffeineBeverage
  def brew
    puts '찻잎을 우려내는 중'
  end

  def add_condiments
    puts '레몬을 추가하는 중'
  end
end
