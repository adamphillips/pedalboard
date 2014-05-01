# Arduino pedal board

This is the software component of an Arduino based MIDI pedalboard. It uses the
[Dino gem](https://github.com/austinbv/dino) to receive signals from the
Arduino and the [Unimidi gem](https://github.com/arirusso/unimidi) to send out
MIDI signals in response.

To start the script

```
bin/pedalboard
```

The commands are configured in
[lib/pedalboard/commands.rb](https://github.com/adamphillips/pedalboard/blob/master/lib/pedalboard/commands.rb).
The pedalboard itself is set up in the [startup
script](https://github.com/adamphillips/pedalboard/blob/master/start.rb).

