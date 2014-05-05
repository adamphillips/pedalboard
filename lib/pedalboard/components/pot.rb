require 'dino/components/base_component'
require 'dino/components/sensor'

require 'pedalboard/components/base_component'

class Pedalboard; module Components
  class Pot < BaseComponent
    TOLERANCE = 2

    UPPER_LIMIT = 127
    LOWER_LIMIT = 0

    attr_reader :change, :inverted,
                :lower_limit, :upper_limit,
                :tolerance

    attr_accessor :value

    def initialize opts={}
      super opts

      @change = opts.fetch(:change) { ->(value) {} }
      @lower_limit = opts.fetch(:lower_limit) { LOWER_LIMIT }
      @upper_limit = opts.fetch(:upper_limit) { UPPER_LIMIT }
      @tolerance = opts.fetch(:tolerance) { TOLERANCE }
      @inverted = opts.fetch(:inverted) { false }
      @value = lower_limit

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

    def normalised received_value
      normalised_value = (
        (received_value.to_i / 1024.0) *
        (upper_limit - lower_limit)
      ).to_i + lower_limit
      normalised_value = upper_limit - normalised_value if inverted
      normalised_value
    end

    def range_to_ignore
      min = value - tolerance
      max = value + tolerance
      (min..max).to_a
    end

    def significant_change? new_value
      if new_value != value
        return true if new_value == lower_limit
        return true if new_value == upper_limit
      end

      !range_to_ignore.include?(new_value)
    end
  end
end; end
