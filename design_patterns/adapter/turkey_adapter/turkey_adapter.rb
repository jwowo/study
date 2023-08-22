require_relative './duck'

class TurkeyAdapter < Duck
  def initialize(turkey)
    @turkey = turkey
  end

  attr_reader :turkey

  def quack
    turkey.gobble
  end

  def fly
    5.times { turkey.fly }
  end
end
