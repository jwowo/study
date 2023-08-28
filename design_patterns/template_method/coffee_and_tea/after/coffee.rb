require_relative 'caffeine_beverage'

class Coffee < CaffeineBeverage
  def brew
    puts '필터로 커피를 우려내는 중'
  end

  def add_condiments
    puts '설탕과 우유를 추가하는 중'
  end
end
