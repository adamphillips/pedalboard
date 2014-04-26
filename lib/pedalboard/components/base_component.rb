require 'dino/components/base_component'

class Pedalboard; module Components
  class BaseComponent
    attr_reader :pin, :pedalboard

    def initialize opts={}
      @pin = opts.fetch(:pin) {}
      @pedalboard = opts.fetch(:pedalboard) {}
    end

  private
    def run_command command, *args
      Commands.new(
        pedalboard: pedalboard
      ).instance_exec *args, &command
    end
  end
end; end
