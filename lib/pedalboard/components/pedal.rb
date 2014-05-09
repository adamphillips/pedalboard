require 'dino/components/base_component'
require 'dino/components/button'

require 'pedalboard/commands'

require_relative 'base_component'

module Pedalboard; module Components
  class Pedal < BaseComponent
    LONG_TIME = 0.4

    attr_reader :press, :long_press

    def initialize opts={}
      super opts

      @press = opts.fetch(:press) { ->{} }
      @long_press = opts.fetch(:long_press) { ->{} }

      configure_dino_component
    end

    def configure_dino_component
      dino_component.down do
        begin
          @start_time = Time.now
        rescue Exception => e
          puts e.message
        end
      end

      dino_component.up do
        begin
          interval = Time.now - @start_time
          if interval > LONG_TIME
            run_command long_press
          else
            run_command press
          end
        rescue Exception => e
          puts e.message
        end
      end
    end

  private
    def dino_component
      @dino_component ||= Dino::Components::Button.new(
        pin: pin,
        board: pedalboard.board
      )
    end
  end
end; end
