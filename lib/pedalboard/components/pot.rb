require 'dino/components/base_component'
require 'dino/components/sensor'

class Pedalboard; module Components
  class Pot < BaseComponent
    TOLERANCE = 2

    UPPER_LIMIT = 127
    LOWER_LIMIT = 0

    attr_reader :change, :value

    def initialize opts={}
      super opts

      @change = opts.fetch(:change) { ->(value) {} }
      @value = 0

      configure_dino_component
    end

  private
    def configure_dino_component
      dino_component.when_data_received do |value|
        begin
          new_value = normalised(value)
          if significant_change?(new_value)
            @value = new_value
            run_command(change, new_value)
          end
        rescue Exception => e
          puts e.message
        end
      end
    end

    def dino_component
      @dino_component ||= Dino::Components::Sensor.new(
        pin: pin,
        board: pedalboard.board
      )
    end

    def normalised value
      ((value.to_i / 1024.0) * 127).to_i
    end

    def range_to_ignore
      min = value - TOLERANCE
      max = value + TOLERANCE
      (min..max).to_a
    end

    def significant_change? new_value
      if new_value != value
        return true if new_value == LOWER_LIMIT
        return true if new_value == UPPER_LIMIT
      end

      !range_to_ignore.include?(new_value)
    end
  end
end; end
