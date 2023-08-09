require_relative './beverages/espresso'
require_relative './beverages/house_blend'
require_relative './condiments/mocha'
require_relative './condiments/soy'

puts '# 테스트 1'
beverage1 = Espresso.new
puts beverage1.description
puts beverage1.cost
puts

puts '# 테스트 2'
beverage2 = HouseBlend.new
puts beverage2.description
puts beverage2.cost
puts

puts '# 테스트 3'
beverage3 = HouseBlend.new
beverage3 = Mocha.new(beverage3)
puts beverage3.description
puts beverage3.cost
puts

puts '# 테스트 4'
beverage4 = Soy.new(Mocha.new(HouseBlend.new))
puts beverage4.description
puts beverage4.cost
puts
