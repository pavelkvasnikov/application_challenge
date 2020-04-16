# frozen_string_literal: true

module Dry
  module Transformer
    Error = Class.new(StandardError)
    FunctionAlreadyRegisteredError = Class.new(Error)

    class FunctionNotFoundError < Error
      def initialize(function, source = nil)
        return super "No registered function #{source}[:#{function}]" if source

        super "No globally registered function for #{function}"
      end
    end
  end
end
