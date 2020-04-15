RSpec.describe Fetcher::FakeFetcher do
  describe '.call' do
    context 'success request' do
      it 'returns ok' do
        response = described_class.call('fake_api', '/fake')
        expect(response.success?).to be true
      end
    end
  end
end
