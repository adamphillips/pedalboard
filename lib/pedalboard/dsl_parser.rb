class Pedalboard
 class DSLParser
    attr_reader :pedalboard

    def initialize pedalboard
      @pedalboard = pedalboard
    end

    def led *args
      @pedalboard.add_component :led, *args
    end

    def pedal *args
      @pedalboard.add_component :pedal, *args
    end

    def pot *args
      @pedalboard.add_component :pot, *args
    end

    def board
      self.pedalboard.board
    end
  end
end
