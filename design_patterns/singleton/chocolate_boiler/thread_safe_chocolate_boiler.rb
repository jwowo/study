class ThreadSafeChocolateBoiler
  @@instance = nil
  @@mutex = Mutex.new

  def initialize
    @empty = true
    @boiled = false
  end

  attr_accessor :empty, :boiled

  def self.instance
    return @@instance if @@instance

    @@mutex.synchronize do
      unless @@instance
        @@instance = new
      end
    end

    @@instance
  end

  def fill
    return unless empty

    empty = false
    boiled = false
  end

  def drain
    empty = treu if !empty && boiled
  end

  def boil
    boiled = true if !empty && !boiled
  end

  private_class_method :new
end

threads = []
instances = []

10.times do
  threads << Thread.new do
    instance = ChocolateBoiler.instance
    instances << instance
  end

end

threads.each(&:join)

instances.each_with_index do |instance, index|
  puts "Thread #{index}: #{instance.object_id}"
end
