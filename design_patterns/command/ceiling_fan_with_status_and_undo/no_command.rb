require_relative 'command'

class NoCommand < Command
  def execute; end

  def undo; end
end
