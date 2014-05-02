class Pedalboard
  class Commands
    attr_reader :pedalboard

    def initialize opts={}
      @pedalboard = opts.fetch(:pedalboard) { }
    end

    def next_set
      puts 'Next set'
      midi do
        note 'c'
      end
    end

    def previous_set
      puts 'Previous set'
      midi do
        note 'd'
      end
    end

    def next_patch
      puts 'Next patch'
      midi do
        note 'e'
      end
    end

    def previous_patch
      puts 'Previous patch'
      midi do
        note 'f'
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
