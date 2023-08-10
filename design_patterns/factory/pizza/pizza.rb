class Pizza
  attr_reader :name

  def prepare
    puts "준비 중: #{name}"
    puts "도우를 돌리는 중..."
    puts "소스를 뿌리는 중..."
    puts "토핑을 올리는 중..."
  end

  def bake
    puts "175도에서 25분 간 굽기"
  end

  def cut
    puts "피자를 사선으로 자르기"
  end

  def box
    puts "상자에 피자 담기"
  end
end
