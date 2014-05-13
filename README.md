# Arduino pedal board

This is the software component of an Arduino based MIDI pedalboard. It uses the
[Dino gem](https://github.com/austinbv/dino) to receive signals from the
Arduino and the [Unimidi gem](https://github.com/arirusso/unimidi) to send out
MIDI signals in response.

### Getting started

- Install the gem

```
gem install pedalboard
```

- Create a startup script for your pedalboard. An example is in [the examples
  folder](https://github.com/adamphillips/pedalboard/tree/master/examples)

- run the script

```
pedalboard script.rb
```

You will be prompted to choose your MIDI input and output
