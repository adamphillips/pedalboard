require 'spec_helper'

require 'pedalboard/components/led'

class Pedalboard; module Components
  describe Led do
    subject { Led.new }

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
  end
end; end
