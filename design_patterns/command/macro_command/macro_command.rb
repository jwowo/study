require_relative '../remote_control/command'

class MacroCommand < Command
  def initialize(commands)
    @commands = commands
  end

  attr_reader :commands

  def execute
    commands.each(&:execute)
  end
end
