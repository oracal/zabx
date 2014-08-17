require 'zabx/json_rpc'

module Zabx
  class Api
    class Query
      def initialize(url, options = {})
        @rpc = JsonRpc.new(url, options)
      end

      def invoke(method, args)
        @rpc.invoke(method, args)
      end

      def method_missing(method, *args)
        if args.length == 1 && args[0].is_a?(Hash)
          invoke(method, args[0])
        else
          invoke(method, args)
        end
      end
    end

    def initialize(url, options)
      @url      = url
      @username = options.delete(:username)
      @password = options.delete(:password)
    end

    def auth
      @auth ||= query(:namespace => :user).login(:user => @username, :password => @password)
    end

    def invoke(method, args = {})
      query(:auth => auth).invoke(method, args)
    end

    def apiinfo
      query :namespace => "apiinfo"
    end

    def method_missing(method, *args)
      query(:auth => auth, :namespace => method)
    end

    private
    def query(options = {})
      Query.new(@url, options)
    end
  end
end
