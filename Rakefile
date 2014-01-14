require 'rubygems'
require 'puppetlabs_spec_helper/rake_tasks'

# Customize lint option
task :lint do
  PuppetLint.configuration.ignore_paths = ["tests/init.pp","spec/fixtures/**/**"]
  PuppetLint.configuration.send("disable_80chars")
  PuppetLint.configuration.send("disable_class_parameter_defaults")
end
