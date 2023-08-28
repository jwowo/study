class CaffeineBeverageWithHook
  def prepare_recipe
    boil_water
    brew
    pour_in_cup
    if customer_wants_condiments
      add_condiments
    end
  end

  def boil_water
    puts '물 끓이는 중'
  end

  def pour_in_cup
    puts '컵에 따르는 중'
  end

  def brew
    raise NotImplementedError
  end

  def add_condiments
    raise NotImplementedError
  end

  def customer_wants_condiments
    true
  end
end
