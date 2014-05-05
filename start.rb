$:.unshift "#{File.dirname(__FILE__)}/lib"

require 'bundler/setup'
require 'dino'
require 'micromidi'
require 'pedalboard'

led1 = nil
led2 = nil
led3 = nil
led4 = nil

altled1 = nil
altled2 = nil
altled3 = nil
altled4 = nil

pedalboard = Pedalboard.create do
  pot pin: 'A0',
    change: ->(value) { set_volume(value) }

  pedal pin: 2,
    press: ->{ patch 1 },
    long_press: ->{ patch 4 }

  pedal pin: 3,
    press: ->{ patch 2 },
    long_press: ->{ patch 5 }

  pedal pin: 4,
    press: ->{ patch 3 },
    long_press: ->{ patch 6 }

  pedal pin: 5,
    press: ->{ next_set },
    long_press: ->{ previous_set }

  led1 = led pin: 6
  led2 = led pin: 11
  led3 = led pin: 8
  led4 = led pin: 9

  altled1 = led pin: 10
  altled2 = led pin: 7
  altled3 = led pin: 12
  altled4 = led pin: 13
end

MIDI.using(pedalboard.midi_input, pedalboard.midi_output) do
  receive do |message|
    if message.index == 22
      begin
        led1.light_if message.value == 1
        led2.light_if message.value == 2
        led3.light_if message.value == 3

        altled1.light_if message.value == 4
        altled2.light_if message.value == 5
        altled3.light_if message.value == 6
      rescue Exception => e
        puts e.message
      end
    end
  end
end

sleep
