Gem::Specification.new do |s|
  s.name         = "zabx"
  s.version      = "0.0.2"
  s.author       = "Thomas Whitton"
  s.email        = "mail@thomaswhitton.com"
  s.homepage     = "https://github.com/oracal/zabx"
  s.platform     = Gem::Platform::RUBY
  s.summary      = "Zabbix api client written in ruby"
  s.description  = "Zabbix api client written in ruby"
  s.require_path = "lib"
  s.license      = "MIT"
  s.files        = ["README.md", "LICENSE.txt", "lib/zabx.rb", "lib/zabx/json_rpc.rb", "lib/zabx/zabx.rb", "lib/zabx/error.rb"]

  s.add_dependency('json', '~> 1.8.1')
  s.add_dependency('faraday', '~> 0.9.0')
  s.add_dependency('faraday_middleware', '~> 0.9.1')
  s.add_dependency('uuidtools', '~> 2.1.5')
end
