require 'pedalboard/dsl_parser'
require 'pedalboard/device'

require 'pedalboard/components/led'
require 'pedalboard/components/pedal'
require 'pedalboard/components/pot'

class Pedalboard
  class << self
    def create opts={}, &block
      device_class = opts.delete(:device_class) { Device }
      dsl_parser = opts.delete(:dsl_parser) { DSLParser }

      parser = dsl_parser.new(
        device_class.new(opts)
      )

      parser.instance_exec(&block) if block_given?

      return parser.pedalboard
    end
  end
end
