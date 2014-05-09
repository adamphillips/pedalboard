require 'spec_helper'

require 'pedalboard/device'
require 'pedalboard/components/pedal'

class Pedalboard
  describe Device do
    describe '#add_component' do
      let(:connection) { double }
      let(:board) { double }
      let(:midi_input) { double }
      let(:midi_output) { double }

      subject { Device.new(
        connection: connection,
        board: board,
        midi_output: midi_output,
        midi_input: midi_input
      ) }

      before :each do
        allow(subject)
          .to receive(:initialize_board)
            .and_return(board)
      end

      it 'should add a component to the board' do
        args = {option1: 'someopt'}
        pedal = double

        expect(Pedalboard::Components::Pedal)
          .to receive(:new)
            .with({
                option1: 'someopt',
                pedalboard: subject
              })
            .and_return(pedal)

        expect(subject.add_component :pedal, args)
          .to be(pedal)

        expect(subject.components.include?(pedal))
          .to be_true
      end
    end
  end
end
