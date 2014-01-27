require 'spec_helper'
require 'rspec-puppet'

describe 'windows_java' do
  include_context 'hieradata'
  let(:title) {'install jdk'}
  let(:facts){{:operatingsystem => 'windows',:architecture => 'x64'}}

  it {
    should contain_pget('Download-jdk-7u45-windows-x64.exe').with({
      'source' => 'http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-windows-x64.exe',
      'target' => 'C:\\temp'
                                                                  })
    should contain_package(
        'Java SE Development Kit 7 Update 45 (64-bit)').with({
        'ensure' => 'present'
        })
    should contain_windows_env('JAVA_HOME').with({
        'value'=>'C:\\Program Files\\Java\\jdk1.7.0_45'
        })
  }
end