require 'spec_helper'

describe "the filename function" do
  let(:scope) { PuppetlabsSpec::PuppetInternals.scope }

  it "should exist" do
    Puppet::Parser::Functions.function("filename").should == "function_filename"
  end
end

