require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.mock_framework = :rspec
  baseFile = File.dirname(__FILE__)
  c.module_path = File.expand_path(File.join(baseFile, 'fixtures/modules'))
  # Using an empty site.pp file to avoid: https://github.com/rodjek/rspec-puppet/issues/15
  c.manifest_dir = File.expand_path(File.join(baseFile, 'fixtures/manifests'))
end
