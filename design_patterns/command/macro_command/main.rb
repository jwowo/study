require_relative 'macro_command'
require_relative '../remote_control/remote_control'
require_relative '../remote_control/light'
require_relative '../remote_control/light_on_command'
require_relative '../remote_control/light_off_command'
require_relative '../ceiling_fan_with_status_and_undo/ceiling_fan'
require_relative '../ceiling_fan_with_status_and_undo/ceiling_fan_high_command'
require_relative '../ceiling_fan_with_status_and_undo/ceiling_fan_off_command'

remote_control = RemoteControl.new

light = Light.new('거실')
light_on = LightOnCommand.new(light)
light_off = LightOffCommand.new(light)

ceiling_fan = CeilingFan.new('거실')
ceiling_fan_high = CeilingFanHighCommand.new(ceiling_fan)
ceiling_fan_off = CeilingFanOffCommand.new(ceiling_fan)

party_on = [light_on, ceiling_fan_high]
party_off = [light_off, ceiling_fan_off]
party_on_macro = MacroCommand.new(party_on)
party_off_macro = MacroCommand.new(party_off)

remote_control.assign_command(0, party_on_macro, party_off_macro)

puts remote_control
puts '--- 매크로 ON ---'
remote_control.on_button_pushed(0)
puts '--- 매크로 OFF ---'
remote_control.off_button_pushed(0)
