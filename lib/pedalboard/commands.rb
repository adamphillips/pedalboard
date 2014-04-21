class Pedalboard
  class Commands
    attr_reader :pedalboard

    def initialize opts={}
      @pedalboard = opts.fetch(:pedalboard) { }
    end

    def next_patch
      puts 'Next patch'
      midi do
        note 'c'
      end
    end

    def previous_patch
      puts 'Previous patch'
      midi do
        note 'e'
      end
    end

    def midi &block
      MIDI.using(pedalboard.midi_output) do
        instance_exec &block
      end
    end
  end
end
