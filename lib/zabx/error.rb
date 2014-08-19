module Zabx
  class Error < StandardError; end

  class JsonRpcError < Error
    attr_reader :code

    def initialize(message, code, data = nil)
      message = "#{code}: #{message}"
      message += " #{data}" unless data.nil?
      super message
      @code = code
    end
  end

  class HttpError < Error; end
  class ConnectionError < Error; end
end
