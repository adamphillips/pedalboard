require 'spec_helper'

require 'pedalboard'

describe Pedalboard do
  describe '.create' do
    let(:connection) { double }
    let(:board) { double }
    let(:midi_input) { double }
    let(:midi_output) { double }
    let(:device_class) { double }
    let(:dsl_parser) { double }

    let(:device_options) {
      {
        connection: connection,
        board: board,
        midi_output: midi_output,
        midi_input: midi_input
      }
    }

    subject { Pedalboard }

    it 'should return a new device instance' do
      device = double
      parser = double

      expect(device_class).to receive(:new)
        .with(device_options)
        .and_return(device)

      expect(dsl_parser).to receive(:new)
        .with(device)
        .and_return(parser)

      expect(parser).to receive(:pedalboard)
        .and_return(device)

      expect(subject.create(
          device_options.merge(
            device_class: device_class,
            dsl_parser: dsl_parser
          )
        )
      ).to equal(device)
    end

    context 'when passed a block' do
      it 'should execute the block in the context of the dsl parser' do
        device = double
        parser = double

        expect(device_class).to receive(:new)
          .with(device_options)
          .and_return(device)

        expect(dsl_parser).to receive(:new)
          .with(device)
          .and_return(parser)

        expect(parser).to receive(:some_method)

        expect(parser).to receive(:pedalboard)
          .and_return(device)

        expect(subject.create(
            device_options.merge(
              device_class: device_class,
              dsl_parser: dsl_parser
            )
          ) do
            some_method
          end
        ).to equal(device)
      end
    end
  end
end
