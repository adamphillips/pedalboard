#
# This is a simple example to blink an led
# every half a second
#
require 'bundler/setup'
require 'dino'

class Encoder < Dino::Components::Sensor
  def after_initialize(options={})
    @data_callbacks = []
    @value = 0
    @board.add_digital_hardware(self)
    @board.start_read
  end
end

board = Dino::Board.new(Dino::TxRx::Serial.new)

encoder_1 = Encoder.new(pin: 8, board: board)
encoder_2 = Encoder.new(pin: 9, board: board)

value = 0

encoder_1.when_data_received do |data|
  puts 'received 1'
  puts data
  value += 1
  puts value
end

encoder_2.when_data_received do |data|
  puts 'received 2'
  puts data
  value -= 1
  puts value
end

sleep

