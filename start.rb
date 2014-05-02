$:.unshift "#{File.dirname(__FILE__)}/lib"

require 'bundler/setup'
require 'dino'
require 'micromidi'
require 'pedalboard'

pedalboard = Pedalboard.create do
  pot pin: 'A0',
    change: ->(value) { set_volume(value) }

  pedal pin: 5,
    press: ->{ next_set }

  pedal pin: 6,
    press: -> { previous_set }

  pedal pin: 7,
    press: ->{ next_patch }

  pedal pin: 8,
    press: -> { previous_patch }

end

led = Dino::Components::Led.new(
  pin: 13, board: pedalboard.board
)

MIDI.using(pedalboard.midi_input, pedalboard.midi_output) do
  receive do |message|
    if message.index == 22
      puts message.value.inspect
      if message.value == 1
        led.send :on
      else
        led.send :off
      end
    end
  end
end

sleep
