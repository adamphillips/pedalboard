require 'pedalboard/dsl_parser'
require 'pedalboard/components/led'
require 'pedalboard/components/pedal'
require 'pedalboard/components/pot'

class Pedalboard

  attr_reader :components, :board, :midi_output, :midi_input

  def initialize opts={}
    @components = []
    @connection = opts.fetch(:connection) { Dino::TxRx::Serial.new }
    @board = opts.fetch(:board) { Dino::Board.new(connection) }
    @midi_output = opts.fetch(:midi_output) { UniMIDI::Output.gets }
    @midi_input = opts.fetch(:midi_input) { UniMIDI::Input.gets }
  end

  def add_component type, opts={}
    opts[:pedalboard] = self
    component =  Object.const_get(component_class(type))
      .new(opts)
    components << component
    component
  end

  class << self
    def create opts={}, &block
      parser = DSLParser.new(new(opts))
      parser.instance_exec(&block) if block_given?

      return parser.pedalboard
    end
  end

private
  attr_reader :connection

  def component_class type
    "Pedalboard::Components::#{type.capitalize}"
  end
end
