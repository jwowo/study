require_relative 'pizza_ingredient_factory'
require_relative 'thin_crust_dough'
require_relative 'marinara_sauce'
require_relative 'reggiano_cheese'
require_relative 'onion'
require_relative 'garlic'

class NyPizzaIngredientFactory < PizzaIngredientFactory
  def create_dough
    ThinCrustDough.new
  end

  def create_sauce
    MarinaraSauce.new
  end

  def create_cheese
    ReggianoCheese.new
  end

  def create_veggies
    [
      Onion.new,
      Garlic.new
    ]
  end

  def create_pepperoni
    SlicedPepperoni.new
  end

  def create_clam
    FreshClams.new
  end
end
