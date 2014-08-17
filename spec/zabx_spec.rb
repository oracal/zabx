require 'spec_helper'

describe Zabx do
  before :each do
    @api = Zabx::Api.new('http://localhost/zabbix/api_jsonrpc.php', :username => 'Admin', :password => 'zabbix')
  end

  describe "#new" do
    it "should take 2 arguments and return Api object" do
      expect(@api).to be_an_instance_of Zabx::Api
    end
  end
end
