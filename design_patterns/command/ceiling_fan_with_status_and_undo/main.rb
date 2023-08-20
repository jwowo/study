require_relative 'ceiling_fan'
require_relative 'ceiling_fan_high_command'
require_relative 'ceiling_fan_medium_command'
require_relative 'ceiling_fan_off_command'
require_relative 'remote_control_with_undo'

remote_control = RemoteControlWithUndo.new

ceiling_fan = CeilingFan.new('거실')

ceiling_fan_high = CeilingFanHighCommand.new(ceiling_fan)
ceiling_fan_medium = CeilingFanMediumCommand.new(ceiling_fan)
ceiling_fan_off = CeilingFanOffCommand.new(ceiling_fan)

remote_control.assign_command(0, ceiling_fan_medium, ceiling_fan_off)
remote_control.assign_command(1, ceiling_fan_high, ceiling_fan_off)

remote_control.on_button_pushed(0)
remote_control.off_button_pushed(0)
puts remote_control
remote_control.undo_button_pushed

remote_control.on_button_pushed(1)
puts remote_control
remote_control.undo_button_pushed
