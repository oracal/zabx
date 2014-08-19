require 'zabx/json_rpc'

module Zabx
  class Api
    def initialize(url, options)
      @url      = url
      @username = options.delete(:username)
      @password = options.delete(:password)
    end

    def auth
      @auth ||= rpc(:namespace => :user).login(:user => @username, :password => @password)
    end

    def invoke(method, args = {})
      rpc(:auth => auth).invoke(method, args)
    end

    def apiinfo
      rpc :namespace => "apiinfo"
    end

    def method_missing method
      rpc(:auth => auth, :namespace => method)
    end

    private
    def rpc(options = {})
      JsonRpc.new(@url, options)
    end
  end
end
