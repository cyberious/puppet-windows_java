require 'spec_helper'
require 'rspec-puppet'

describe 'windows_java' do
  let(:title) { 'install jdk' }
  let(:facts) { {:operatingsystem => 'windows', :architecture => 'x64', :windows_java_temp => 'C:\temp'} }
  let(:params) { {:version => '8u45'} }
  it {
    should contain_windows_java__download('Download-jdk-8u45-windows-x64.exe').with(
               {
                   'source' => 'http://download.oracle.com/otn-pub/java/jdk/8u45-b15/jdk-8u45-windows-x64.exe',
                   'filename' => 'jdk-8u45-windows-x64.exe',
                   'temp_target' => 'C:\temp'
               })
  }
  it {
    should contain_package(
               'Java SE Development Kit 8 Update 45 (64-bit)').with(
               {
                   'ensure' => 'present'
               })
  }
  it {
    should contain_windows_env('JAVA_HOME').with_value('C:\Program Files\Java\jdk1.8.0_45')
  }
end