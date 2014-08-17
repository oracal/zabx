module Zabx
  class Error < StandardError; end

  class JsonRpcError < Error
    attr_reader :message, :code, :data

    def initialize(message, code, data = nil)
      @message = message
      @code = code
      @data = data
    end

    def to_s
      output = "#{code}: #{message}"
      output += " #{data}" unless data.nil?
    end
  end

  class HttpError < Error; end
  class ConnectionError < Error; end
end
