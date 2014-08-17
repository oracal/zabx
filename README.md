Zabx
====

Zabbix api client written in ruby.

Example
=======

```ruby
require 'zabx'

api = Zabx::Api.new('http://localhost/zabbix/api_jsonrpc.php', :username => 'Admin', :password => 'zabbix')

api.apiinfo.version
api.event.get
api.user.create({
  :alias   => 'alias',
  :name    => 'name',
  :surname => 'surname',
  :passwd  => 'password',
  :usrgrps => [{
    :usrgrpid => "7"
  }]
})

License
=======

MIT
