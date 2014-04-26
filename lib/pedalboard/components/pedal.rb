require 'dino/components/base_component'
require 'dino/components/button'

require 'pedalboard/commands'

require_relative 'base_component'

class Pedalboard; module Components
  class Pedal < BaseComponent
    attr_reader :press, :release

    def initialize opts={}
      super opts

      @press = opts.fetch(:press) { ->{} }
      @release = opts.fetch(:release) { ->{} }

      configure_dino_component
    end

    def configure_dino_component
      dino_component.down do
        begin
          run_command press
        rescue Exception => e
          puts e.message
        end
      end

      dino_component.up do
        begin
          run_command release
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
