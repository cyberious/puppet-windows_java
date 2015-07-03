source "https://rubygems.org"

group :development, :test do
  gem 'rspec', "~> 3.0", :require => false
  gem 'puppetlabs_spec_helper', :require => false
  gem 'pry'
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

puppetversion = ENV['PUPPET_GEM_VERSION']
if puppetversion
  gem 'puppet', puppetversion
else
  gem 'puppet', :require => false
end

