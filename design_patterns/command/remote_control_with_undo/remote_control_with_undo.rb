require_relative 'no_command'

class RemoteControlWithUndo
  def initialize
    no_command = NoCommand.new
    @on_commands = Array.new(7, no_command)
    @off_commands = Array.new(7, no_command)
    @undo_command = no_command
  end

  attr_reader :on_commands, :off_commands
  attr_accessor :undo_command

  def assign_command(slot_num, on_command, off_command)
    on_commands[slot_num] = on_command
    off_commands[slot_num] = off_command
  end

  def on_button_pushed(slot_num)
    on_commands[slot_num].execute
    @undo_command = on_commands[slot_num]
  end

  def off_button_pushed(slot_num)
    off_commands[slot_num].execute
    @undo_command = off_commands[slot_num]
  end

  def undo_button_pushed
    undo_command.undo
  end

  def to_s
    info = ['----- 리모컨 -----']
    (0..on_commands.length - 1).each do |i|
      info << "[slot #{i}] #{on_commands[i].class} #{off_commands[i].class}"
    end
    info << "[undo] #{undo_command.class}"

    info.join("\n")
  end
end
