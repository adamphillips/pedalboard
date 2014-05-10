require_relative '../commands'

module Pedalboard; module Components
  class BaseComponent
    attr_reader :pin, :pedalboard

    def initialize opts={}
      @pin = opts.fetch(:pin) {}
      @pedalboard = opts.fetch(:pedalboard) {}
      @dino_component = opts.fetch(:dino_component) {}
    end

  private
    def run_command command, *args
      Commands.new(
        pedalboard: pedalboard
      ).instance_exec *args, &command
    end
  end
end; end
