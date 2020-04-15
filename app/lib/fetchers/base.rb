module Fetcher
  # Base class for sending HTTP requests
  class Base

    HTTP_EXCEPTIONS = [
      Errno::EADDRNOTAVAIL,
      Errno::ECONNRESET,
      Errno::ECONNABORTED,
      Net::HTTPError
    ].freeze

    def self.call(url, path, options = {})
      new(url, path, options).call
    end

    def initialize(url, path, options = {})
      @url = url
      @path = path
      @options = options
    end

    def call
      response = Net::HTTP.get_response(@url, @path, 4567)
      case response
      when Net::HTTPSuccess
        Common::Result.from_ok(response.body)
      else
        Common::Result.from_err(response)
      end
    rescue *HTTP_EXCEPTIONS => e
      Common::Result.from_err(e)
    end

  end
end
