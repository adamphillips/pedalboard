class Pedalboard
 class DSLParser
    attr_reader :pedalboard

    def initialize pedalboard
      @pedalboard = pedalboard
    end

    def pedal *args
      @pedalboard.add_component :pedal, *args
    end

    def board
      self.pedalboard.board
    end
  end
end
