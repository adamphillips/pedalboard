#
# This is a simple example to blink an led
# every half a second
#
require 'bundler/setup'
require 'dino'

board = Dino::Board.new(Dino::TxRx::Serial.new)
led = Dino::Components::Led.new(pin: 13, board: board)
button = Dino::Components::Button.new(pin: 2, board: board)

button.up do
  puts 'button pressed'
  led.send :on
end

button.down do
  puts 'button released'
  led.send :off
end

sleep
