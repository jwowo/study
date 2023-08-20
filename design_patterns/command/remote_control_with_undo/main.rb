require_relative 'light'
require_relative 'light_on_command'
require_relative 'light_off_command'
require_relative 'remote_control_with_undo'

remote_control = RemoteControlWithUndo.new

living_room_light = Light.new('거실')
living_room_light_on = LightOnCommand.new(living_room_light)
living_room_light_off = LightOffCommand.new(living_room_light)
remote_control.assign_command(0, living_room_light_on, living_room_light_off)


remote_control.on_button_pushed(0)
remote_control.off_button_pushed(0)
puts remote_control
remote_control.undo_button_pushed
remote_control.off_button_pushed(0)
remote_control.on_button_pushed(0)
puts remote_control
remote_control.undo_button_pushed
