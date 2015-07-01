source "https://rubygems.org"

group :development, :test do
  gem 'rake'
  gem 'rspec', "~> 2.14.0", :require => false
  gem 'mocha', "~> 0.10.5", :require => false
  gem 'puppetlabs_spec_helper', :require => false
  gem 'rspec-puppet', :require => false
  gem 'puppet-lint'
end

group :system_tests do
  gem 'beaker-rspec'
  gem 'beaker-puppet_install_helper'
  gem 'serverspec'
end

facterversion = ENV['GEM_FACTER_VERSION']
if facterversion
  gem 'facter', facterversion
else
  gem 'facter', :require => false
end

ENV['GEM_PUPPET_VERSION'] ||= ENV['PUPPET_GEM_VERSION']
puppetversion = ENV['GEM_PUPPET_VERSION']
if puppetversion
  gem 'puppet', puppetversion
else
  gem 'puppet', :require => false
end

