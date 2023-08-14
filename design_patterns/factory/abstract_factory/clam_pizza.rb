require_relative 'pizza'

class ClamPizza < Pizza
  def initialize(ingredient_factory)
    @name = '조개 피자'
    @ingredient_factory = ingredient_factory
  end

  attr_reader :name, :ingredient_factory

  def prepare
    puts "준비 중: #{name}"
    @dough = ingredient_factory.create_dough
    @sauce = ingredient_factory.create_sauce
    @cheese = ingredient_factory.create_cheese
    @clam = ingredient_factory.create_clam
  end
end
