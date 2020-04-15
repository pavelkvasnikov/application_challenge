require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'vcr_cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

RSpec.describe Fetcher::Base do

  describe '.call' do

    context 'error request' do
      it 'returns error' do
        expect(described_class.call('localhost', '/fake').err?).to be true
      end
    end

    context 'success request' do
      it 'returns ok' do
        VCR.use_cassette('fake_api') do
          response = described_class.call('fake_api', '/fake')
          expect(response.success?).to be true
        end
      end
    end

  end

end
