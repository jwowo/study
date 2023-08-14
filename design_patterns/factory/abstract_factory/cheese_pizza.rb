require_relative 'pizza'

class CheesePizza < Pizza
  def initialize(ingredient_factory)
    @name = '치즈 피자'
    @ingredient_factory = ingredient_factory
  end

  attr_reader :name, :ingredient_factory

  def prepare
    @dough = ingredient_factory.create_dough
    @sauce = ingredient_factory.create_sauce
    @cheese = ingredient_factory.create_cheese
    @veggies = ingredient_factory.create_veggies
    veggie_names = veggies.map(&:name).join(', ')

    puts "준비 중: #{name}"
    puts "#{@dough.name}를 돌리는 중..."
    puts "#{@cheese.name}를 돌리는 중..."
    puts "#{@sauce.name}를 뿌리는 중..."
    puts "토핑을 올리는 중 : #{veggie_names}"
  end
end
