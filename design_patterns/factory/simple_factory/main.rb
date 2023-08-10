require_relative 'pizza_store'
require_relative 'simple_pizza_factory'

simple_pizza_factory = SimplePizzaFactory.new
pizza_store = PizzaStore.new(simple_pizza_factory)
pizza_store.order_pizza('cheese')
