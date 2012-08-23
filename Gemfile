source :rubygems
gem 'puppetlabs_spec_helper'

puppetversion = ENV.key?('PUPPET_VERSION') ? "= #{ENV['PUPPET_VERSION']}" : ['= 2.7.14']
gem 'puppet', puppetversion
gem 'puppet-lint'

if defined?(JRUBY_VERSION)
  gem 'jruby-openssl'
end
