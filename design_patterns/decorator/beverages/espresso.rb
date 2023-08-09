require_relative 'beverage'

class Espresso < Beverage
  def initialize
    super
    @description = '에스프레소'
  end

  def cost
    1.99
  end
end