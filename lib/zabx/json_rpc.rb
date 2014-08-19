require 'faraday'
require 'faraday_middleware'
require 'uuidtools'
require 'zabx/error'

module Zabx
  class JsonRpc
    JSON_RPC_VERSION = "2.0"

    def initialize(url, options = {})
      @url = url
      @connection = Faraday.new do |connection|
        connection.request  :json
        connection.response :json, :content_type => /\bjson$/
        connection.response :follow_redirects
        connection.adapter Faraday.default_adapter
      end

      @namespace = options.delete :namespace
      @options = options
    end

    def invoke(method, args)
      response = request(method, args)
      status_code_check(response)
      parse_response(response.body)
    end

    def method_missing(method, *args)
      if args.length == 1 && args[0].is_a?(Hash)
        invoke(method, args[0])
      else
        invoke(method, args)
      end
    end

    private

    def request(method, args)
      namespaced_method = @namespace.nil? ? method : "#{@namespace}.#{method}"
      body = @options.merge({
        :jsonrpc => JSON_RPC_VERSION,
        :method  => namespaced_method,
        :params  => args,
        :id      => UUIDTools::UUID.random_create.to_i
      })
      @connection.post @url, body
    rescue Faraday::ConnectionFailed => exception
      raise ConnectionError, exception.message
    end

    def parse_response(response)
      error_check response
      response["result"]
    end

    def error_check response
      if response.has_key? "error"
        error = response["error"]
        raise JsonRpcError.new(error["message"], error["code"], error["data"])
      end
    end

    def status_code_check response
      case response.status
      when 400...500
        raise HttpError, "HTTP client error with status code #{response.status}"
      when 500...600
        raise HttpError, "HTTP server error with status code #{response.status}"
      end
    end
  end
end
