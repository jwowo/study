class Tea
  def prepare_recipe
    boil_water
    steep_tea_bag
    pour_in_cup
    add_sugar_and_milk
  end

  def boil_water
    puts '물 끓이는 중'
  end

  def steep_tea_bag
    puts '찻잎을 우려내는 중'
  end

  def pour_in_cup
    puts '컵에 따르는 중'
  end

  def add_remon
    puts '레몬을 추가하는 중'
  end
end
