$:.unshift "#{File.dirname(__FILE__)}/lib"

require 'bundler/setup'
require 'dino'
require 'micromidi'
require 'pedalboard'

led1 = nil
led2 = nil
led3 = nil
led4 = nil

pedalboard = Pedalboard.create do
  pot pin: 'A0',
    change: ->(value) { set_volume(value) }

  pedal pin: 2,
    press: ->{ next_set }

  pedal pin: 3,
    press: -> { previous_set }

  pedal pin: 4,
    press: ->{ next_patch }

  pedal pin: 5,
    press: -> { previous_patch }

  led1 = led pin: 13
  led2 = led pin: 12
  led3 = led pin: 11
  led4 = led pin: 10
end

MIDI.using(pedalboard.midi_input, pedalboard.midi_output) do
  receive do |message|
    if message.index == 22
      begin
        led1.light_if message.value == 1
        led2.light_if message.value == 2
        led3.light_if message.value == 3
        led4.light_if message.value == 4
      rescue Exception => e
        puts e.message
      end
    end
  end
end

sleep
