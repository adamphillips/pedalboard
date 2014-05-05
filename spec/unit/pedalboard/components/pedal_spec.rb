require 'spec_helper'

require 'dino/board'
require 'pedalboard/components/pedal'

describe Pedalboard::Components::Pedal do
  describe '#initialize' do
    let(:board) { double('Dino::Board') }
    let(:pedalboard) { double(board: board) }
    let(:pin) { double }
    let(:press) { double }
    let(:long_press) { double }

    subject { Pedalboard::Components::Pedal.new(
        pedalboard: pedalboard,
        pin: pin,
        press: press,
        long_press: long_press
      ) }

    before :each do
      Pedalboard::Components::Pedal
        .any_instance
        .stub(:configure_dino_component)
    end

    its(:pedalboard) { should equal pedalboard }
    its(:pin) { should equal pin }
    its(:press) { should equal press }
    its(:long_press) { should equal long_press }
  end
end
