require 'mixlib/cli'

require_relative '../pedalboard'

module Pedalboard
  class CLI
    include Mixlib::CLI

    def create_device filename
      contents = File.open(filename).read
      Pedalboard.create do
        eval contents
      end
    end

    def run args
      options = parse_options(args)
      options.each { |file| create_device file }
    end
  end
end
