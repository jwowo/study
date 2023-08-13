require_relative 'ny_pizza_store'
require_relative 'chicaog_pizza_store'

ny_pizza_store = NyPizzaStore.new
chicaog_pizza_store = ChicaogPizzaStore.new

pizza = ny_pizza_store.order_pizza('cheese')
puts "1번으로 주문한 + #{pizza.name}"
puts

pizza = chicaog_pizza_store.order_pizza('cheese')
puts "2번으로 주문한 + #{pizza.name}"
puts
