RSpec.describe Loggun::Config do
  describe 'configure' do
    before do
      Singleton.send :__init__, described_class
    end

    let!(:instance) { described_class.instance }
    let!(:precision) { %i[micros microseconds us].sample }
    let!(:pattern) { '%{time} %{message}' }
    let!(:message_format) { :json }

    subject do
      described_class.configure do |config|
        config.precision = precision
        config.pattern = pattern
        config.message_format = message_format
      end
    end

    context 'pass all configs' do
      it 'set configs' do
        subject

        expect(instance.precision).to eq(precision)
        expect(instance.pattern).to eq(pattern)
        expect(instance.message_format).to eq(message_format)
      end
    end

    context 'when message_format has unknown value' do
      let!(:message_format) { :test }

      it 'raise error FailureConfiguration' do
        expect { subject }.to raise_error(described_class::FailureConfiguration)
      end
    end
  end
end
