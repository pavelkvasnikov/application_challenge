RSpec.describe Common::Result do

  describe '.from_err' do

    it 'returns error' do
      expect(described_class.from_err('err').err?).to be true
      expect(described_class.from_err('err').success?).to be false
      expect(described_class.from_err('err').unwrap).to match(error: 'err')
    end
  end

  describe '.from_ok' do
    it 'returns data' do
      expect(described_class.from_ok('ok').err?).to be false
      expect(described_class.from_ok('ok').success?).to be true
      expect(described_class.from_ok('ok').unwrap).to match(data: 'ok')
    end
  end
end
