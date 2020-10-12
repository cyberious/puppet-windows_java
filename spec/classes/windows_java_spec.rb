require 'spec_helper'
require 'rspec-puppet'

provider_class = Puppet::Type.type(:package).provider(:windows)

describe 'windows_java' do
  before :each do
    Puppet::Type.type(:package).stubs(:defaultprovider).returns(provider_class)
  end
  let(:title) { 'install jdk' }
  let(:facts) { {:operatingsystem => 'windows', :architecture => 'x64', :windows_java_temp => 'C:\temp'} }
  let(:params) {
    {
      'ensure' => 'present',
      'version' => '8u45',
      'build_number_hash' => { '8u45' => 'b15' },
      'default' => true,
      'source' => 'http://download.oracle.com/otn-pub/java/jdk/8u45-b15/jdk-8u45-windows-x64.exe'
    }
  }
  it {
    is_expected.to contain_windows_java__jdk('8u45').with(
      {
        'ensure' => 'present',
        'version' => '8u45',
        'arch' => 'x64',
        'build_number_hash' => { '8u45' => 'b15' },
        'default' => true,
        'source' => 'http://download.oracle.com/otn-pub/java/jdk/8u45-b15/jdk-8u45-windows-x64.exe',
        'temp_target' => 'C:\temp'
      }
    )
  }
  it {
    is_expected.to contain_package('Java SE Development Kit 8 Update 45 (64-bit)').with(
      {
        'ensure' => 'present'
      }
    )
  }
  it { should contain_windows_env('JAVA_HOME').with_value('C:\Program Files\Java\jdk1.8.0_45') }
end
