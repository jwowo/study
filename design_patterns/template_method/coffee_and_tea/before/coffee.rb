class Coffee
  def prepare_recipe
    boil_water
    brew_coffee_grinds
    pour_in_cup
    add_sugar_and_milk
  end

  def boil_water
    puts '물 끓이는 중'
  end

  def brew_coffee_grinds
    puts '필터로 커피를 우려내는 중'
  end

  def pour_in_cup
    puts '컵에 따르는 중'
  end

  def add_sugar_and_milk
    puts '설탕과 우유를 추가하는 중'
  end
end
