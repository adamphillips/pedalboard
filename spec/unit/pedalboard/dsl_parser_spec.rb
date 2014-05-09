require 'spec_helper'

require 'pedalboard/dsl_parser'

module Pedalboard
  describe DSLParser do
    def pedalboard
      @pedalboard ||= double
    end

    describe '#initialize' do
      subject { DSLParser }

      it 'should accept a board' do
        expect(subject.new(pedalboard).pedalboard)
          .to equal(pedalboard)
      end
    end

    describe '#board' do
      let (:board) { double }
      let (:pedalboard) { double(board: board) }

      subject { DSLParser.new(pedalboard).board }

      it { should == board }
    end

    describe 'components' do
      let(:args) { double }
      subject { DSLParser.new(pedalboard) }

      describe '#led' do
        it 'should create a led component' do
          expect(pedalboard)
            .to receive(:add_component)
              .with(:led, args)

          subject.led args
        end
      end

      describe '#pedal' do
        it 'should create a pedal component' do
          expect(pedalboard)
            .to receive(:add_component)
              .with(:pedal, args)

          subject.pedal args
        end
      end

      describe '#pot' do
        it 'should create a pot component' do
          expect(pedalboard)
            .to receive(:add_component)
              .with(:pot, args)

          subject.pot args
        end
      end
    end
  end
end
