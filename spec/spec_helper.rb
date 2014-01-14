require 'puppetlabs_spec_helper/module_spec_helper'
require 'hiera-puppet-helper/rspec'
require 'hiera'


def param_value(subject, type, title, param)
  subject.resource(type, title).send(:parameters)[param.to_sym]
end

RSpec.configure do |c|
  c.mock_framework = :rspec
  c.module_path  = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures/modules'))
  # Using an empty site.pp file to avoid: https://github.com/rodjek/rspec-puppet/issues/15
  c.manifest_dir = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures/manifests'))
end


data_path = File.expand_path(File.join(__FILE__, '..', 'fixtures','modules','hieradata'))
shared_context "hieradata" do
  let(:hiera_config) do
    { :backends => ['rspec', 'yaml'],
      :hierarchy => ['common'],
      :yaml => {
          :datadir => data_path},
      :rspec => respond_to?(:hiera_data) ? hiera_data : {} }
  end
end
