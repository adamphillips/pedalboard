class Pedalboard
  class Commands
    NOTES = [
      'c1', 'd1', 'e1',
      'f1', 'g1', 'a1'
    ]

    attr_reader :pedalboard

    def initialize opts={}
      @pedalboard = opts.fetch(:pedalboard) { }
    end

    def patch number
      midi do
        note NOTES[number - 1]
      end
    end

    def next_set
      midi do
        note 'b1'
      end
    end

    def previous_set
      midi do
        note 'c2'
      end
    end

    def set_volume value
      midi do
        cc 7, value
      end
    end

    def midi &block
      MIDI.using(pedalboard.midi_input, pedalboard.midi_output) do
        instance_exec &block
      end
    end
  end
end
