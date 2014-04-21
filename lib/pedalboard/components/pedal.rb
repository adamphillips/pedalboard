require 'dino/components/base_component'
require 'dino/components/button'

require 'pedalboard/commands'

class Pedalboard; module Components
  class Pedal
    attr_reader :pin, :pedalboard,
                  :press, :release

    def initialize opts={}
      @pin = opts.fetch(:pin) {}
      @pedalboard = opts.fetch(:pedalboard) {}
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

    def run_command command
      Commands.new(
        pedalboard: pedalboard
      ).instance_exec &command
    end
  end
end; end
