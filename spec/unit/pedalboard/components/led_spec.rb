require 'spec_helper'

require 'pedalboard/components/led'

module Pedalboard; module Components
  describe Led do
    let(:dino_component) { double }

    subject { Led.new(
      dino_component: dino_component
    ) }

    describe '#light_if' do
      context 'when passed true' do
        it 'should turn the led on' do
          expect(subject).to receive(:on)
          subject.light_if true
        end
      end

      context 'when passed false' do
        it 'should turn the led off' do
          expect(subject).to receive(:off)
          subject.light_if false
        end
      end
    end

    describe '#off' do
      it 'should turn the led off' do
        expect(dino_component).to receive(:send).with(:off)
        subject.off
      end
    end

    describe '#on' do
      it 'should turn the led on' do
        expect(dino_component).to receive(:send).with(:on)
        subject.on
      end
    end
  end
end; end
