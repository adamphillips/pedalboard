require 'spec_helper'

require 'pedalboard/cli'

module Pedalboard
  describe CLI do
    subject { CLI.new }

    describe '#create_device' do
      it 'should load the contents of the file and use them to create the device' do
        filename = double
        file = double
        config = 'some_method'
        config_proc = double

        expect(File).to receive(:open)
          .with(filename)
          .and_return(file)

        expect(file).to receive(:read)
          .and_return(config)

        expect(Pedalboard).to receive(:create)

        subject.create_device(filename)
      end
    end

    describe '#run' do
      context 'when passed a single file' do
        let(:args) { ['a-file'] }

        it 'should create a device from the file' do
          expect(subject).to receive(:create_device).with('a-file')
          subject.run(args)
        end
      end
    end
  end
end
