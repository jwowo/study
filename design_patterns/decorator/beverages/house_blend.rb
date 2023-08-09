require_relative 'beverage'

class HouseBlend < Beverage
  def initialize
    super
    @description = '하우스 블렌드 커피'
  end

  def cost
    0.89
  end
end