require_relative 'simple_remote_control'
require_relative 'light_on_command'
require_relative 'light'

remote = SimpleRemoteControl.new
light = Light.new
light_on = LightOnCommand.new(light)

remote.command = light_on
remote.button_pressed
