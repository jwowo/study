require_relative 'light'
require_relative 'light_on_command'
require_relative 'light_off_command'
require_relative 'remote_control'

remote_control = RemoteControl.new

living_room_light = Light.new('거실')
kitchen_light = Light.new('주방')

living_room_light_on = LightOnCommand.new(living_room_light)
living_room_light_off = LightOffCommand.new(living_room_light)
kitchen_light_on = LightOnCommand.new(kitchen_light)
kitchen_light_off = LightOffCommand.new(kitchen_light)

remote_control.assign_command(0, living_room_light_on, living_room_light_off)
remote_control.assign_command(1, kitchen_light_on, kitchen_light_off)

puts remote_control

remote_control.on_button_pushed(0)
remote_control.off_button_pushed(0)
remote_control.on_button_pushed(1)
remote_control.off_button_pushed(1)
