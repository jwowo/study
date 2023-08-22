require_relative './mallard_duck'
require_relative './wild_turkey'
require_relative './turkey_adapter'

def test_duck(duck)
  duck.quack
  duck.fly
end

duck = MallardDuck.new
turkey = WildTurkey.new
turkey_adapter = TurkeyAdapter.new(turkey)

puts '칠면조가 말하길'
turkey.gobble
turkey.fly
puts

puts '오리가 말하길'
duck.quack
duck.fly
puts

puts '칠면조 어댑터가 말하길'
test_duck(turkey_adapter)
