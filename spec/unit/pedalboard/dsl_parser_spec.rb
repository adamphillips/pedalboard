require 'spec_helper'

require 'pedalboard/dsl_parser'

describe Pedalboard::DSLParser do
  def pedalboard
    @pedalboard ||= double
  end

  describe '#initialize' do
    subject { Pedalboard::DSLParser }

    it 'should accept a board' do
      expect(subject.new(pedalboard).pedalboard)
        .to equal(pedalboard)
    end
  end

  describe '#board' do
    let (:board) { double }
    let (:pedalboard) { double(board: board) }

    subject { Pedalboard::DSLParser.new(pedalboard).board }

    it { should == board }
  end

  describe '#pedal' do
    subject { Pedalboard::DSLParser.new(pedalboard) }

    it 'should create a pedal component' do
      args = double

      expect(pedalboard)
        .to receive(:add_component)
          .with(:pedal, args)

      subject.pedal args
    end
  end
end
