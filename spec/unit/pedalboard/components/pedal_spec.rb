require 'spec_helper'

require 'dino/board'
require 'pedalboard/components/pedal'

describe Pedalboard::Components::Pedal do
  describe '#initialize' do
    let(:board) { double('Dino::Board') }
    let(:pedalboard) { double(board: board) }
    let(:pin) { double }
    let(:press) { double }
    let(:release) { double }

    subject { Pedalboard::Components::Pedal.new(
        pedalboard: pedalboard,
        pin: pin,
        press: press,
        release: release
      ) }

    before :each do
      Pedalboard::Components::Pedal
        .any_instance
        .stub(:configure_dino_component)
    end

    its(:pedalboard) { should equal pedalboard }
    its(:pin) { should equal pin }
    its(:press) { should equal press }
    its(:release) { should equal release }
  end
end
