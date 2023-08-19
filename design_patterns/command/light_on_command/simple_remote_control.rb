class SimpleRemoteControl
  def initialize
    @command
  end

  attr_accessor :command

  def button_pressed
    command.execute
  end
end
