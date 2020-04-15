RSpec.describe Processor::DefaultProcessor do

  describe '.call' do

    it 'calls method chain' do
      allow(described_class).to receive(:call)
      allow(subject).to receive(:call)

      expect(described_class).to receive(:call)
      expect(subject).to receive(:call)

      described_class.call
      subject.call
    end
  end
end
