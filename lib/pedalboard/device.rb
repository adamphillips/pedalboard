module Pedalboard
  class Device

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
      component =  eval(component_class(type))
        .new(opts)
      components << component
      component
    end

  private
    attr_reader :connection

    def component_class type
      "Pedalboard::Components::#{type.capitalize}"
    end
  end
end
