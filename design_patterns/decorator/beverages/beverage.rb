class Beverage
  def initialize
    @description = '제목 없음'
  end

  attr_accessor :description

  def cost
    raise NotImplementedError
  end
end