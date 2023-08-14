class Pizza
  attr_accessor :name
  attr_reader :dough, :sauce, :veggies, :cheese, :peppernoi

  def prepare
    raise NotImplementedError
  end

  def bake
    puts '175도에서 25분 간 굽기'
  end

  def cut
    puts '피자를 사선으로 자르기'
  end

  def box
    puts '상자에 피자 담기'
  end
end
