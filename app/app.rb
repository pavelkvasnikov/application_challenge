require './lib/app'

def call(event:, context:)
  Processor::DefaultProcessor.call
end

alias :handler :call
