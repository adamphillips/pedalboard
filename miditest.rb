require 'micromidi'

@input = UniMIDI::Input.gets
@output = UniMIDI::Output.gets

MIDI.using(@output) do

  play "C3", 0.5

end
