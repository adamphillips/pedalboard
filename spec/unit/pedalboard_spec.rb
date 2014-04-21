require 'spec_helper'

require 'pedalboard'
require 'pedalboard/components/pedal'

describe Pedalboard do
  def connection
    @connection ||= double
  end

  def board
    @board ||= double
  end

  describe '#add_component' do
    subject { Pedalboard.new(
      connection: connection,
      board: board
    ) }

    before :each do
      @board = double

      allow(subject)
        .to receive(:initialize_board)
          .and_return(@board)
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

  describe '.create' do
    subject { Pedalboard }

    it 'should return an instance of the pedalboard' do
      expect(subject.create(
          connection: connection,
          board: board
        )).to be_kind_of subject
    end

    it 'should take a block containing components' do
      board_double = double('Pedalboard')
      expect(board_double).to receive(:add_component).with(:pedal, pin: 3)

      allow(subject).to receive(:new).and_return(board_double)

      pedalboard = subject.create do
        pedal pin: 3
      end
    end
  end
end
