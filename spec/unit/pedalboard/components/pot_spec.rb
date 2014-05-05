require 'spec_helper'

require 'pedalboard/components/pot'

class Pedalboard; module Components
  describe Pot do
    let(:tolerance) { 10 }
    let(:upper_limit) { 110 }
    let(:lower_limit) { 10 }
    let(:inverted) { false }
    let(:change) { ->(value) { puts 'poop'; change_value = value } }
    let(:dino_component) { Dino::Components::Sensor.new(board: board, pin: 1) }
    let(:board) { double(add_analog_hardware: nil, start_read: nil) }
    let(:pedalboard) { double(board: board) }

    subject { Pot.new(
      tolerance: tolerance,
      upper_limit: upper_limit,
      lower_limit: lower_limit,
      inverted: inverted,
      change: change,
      pedalboard: pedalboard,
      dino_component: dino_component
    ) }

    context 'when the dino component recieves data' do
      it 'should call the change proc with the normalised value' do
        expect(subject.value).to equal(10)
        expect(subject).to receive(:run_command).with(change, 35)
        dino_component.update 256
        expect(subject.value).to equal(35)
      end

      context 'when the change is within the tolerance' do
        it 'should not change the value' do
          subject.value = 34
          expect(subject).to_not receive(:run_command).with(change, 35)
          dino_component.update 256
          expect(subject.value).to equal(34)
        end
      end

      context 'when inverted' do
        let(:inverted) { true }

        it 'should call the change proc with the inverted value' do
          expect(subject).to receive(:run_command).with(change, 75)
          dino_component.update 256
          expect(subject.value).to equal(75)
        end
      end
    end
  end
end; end
