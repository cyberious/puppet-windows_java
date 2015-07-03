require 'spec_helper_acceptance'

RSpec.describe 'windows_java::jdk' do

  describe '8u45' do
    it {
      pp = <<-PP
  windows_java::jdk{'Install 8u45':
    version => '8u45',
  }
      PP
      apply_manifest_on default, pp
    }
    describe package('Java SE Development Kit 8 Update 45 (64-bit)') do
      it { should be_installed }
    end
  end

  describe '7u51' do
    it {
      pp = <<-PP
  windows_java::jdk{'Install 7u67':
    version => '7u67',
    default => false,
    source => 'http://int-resources.ops.puppetlabs.net/QA_resources/java/jdk-7u67-windows-x64.exe',
  }
      PP
      apply_manifest_on default, pp
    }
    describe package('Java SE Development Kit 7 Update 67 (64-bit)') do
      it { should be_installed }
    end

  end

end