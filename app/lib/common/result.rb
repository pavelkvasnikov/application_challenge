module Common
  # Inspired by Rust's Result<T, E>
  class Result
    def self.from_err(err)
      new(error: err)
    end

    def self.from_ok(ok)
      new(data: ok)
    end

    def initialize(params)
      @result = params
    end

    def success?
      !@result[:data].nil? && @result[:error].nil?
    end

    def err?
      !@result[:error].nil?
    end

    def unwrap
      @result
    end
  end
end
