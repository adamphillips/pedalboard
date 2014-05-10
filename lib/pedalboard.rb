require_relative 'pedalboard/cli'
require_relative 'pedalboard/dsl_parser'
require_relative 'pedalboard/device'

require_relative 'pedalboard/components/led'
require_relative 'pedalboard/components/pedal'
require_relative 'pedalboard/components/pot'

module Pedalboard
  def self.create opts={}, &block
    device_class = opts.delete(:device_class) { Device }
    dsl_parser = opts.delete(:dsl_parser) { DSLParser }

    parser = dsl_parser.new(
      device_class.new(opts)
    )

    parser.instance_exec(&block) if block_given?

    return parser.pedalboard
  end
end
