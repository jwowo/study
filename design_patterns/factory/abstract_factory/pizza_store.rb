class PizzaStore
  def order_pizza(type)
    pizza = create_pizza(type)

    pizza.prepare
    pizza.bake
    pizza.cut
    pizza.box
    pizza
  end

  def create_pizza(_type)
    raise NotImplementedError
  end
end
