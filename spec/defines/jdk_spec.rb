require 'spec_helper'
require 'rspec-puppet'
require 'hiera-puppet-helper'

describe 'windows_java::jdk', :type => :define do
  describe 'when deploying with defaults' do
    let(:title){'Install JDK'}
    let(:facts){{:operatingsystem => "windows"}}
    include_context 'hieradata'
    let(:hiera_data){{
        '7u45'=> {
            'x64'=>{
                'install_name' => 'Java SE Development Kit 7 Update 45 (64-bit)',
                'install_path' => "C:\\Program Files\\Java\\jdk1.7.0_45",
                'source'      => "https://mydomain/jdk-7u45-windows-x64.exe"
            }}}}
    it {
      should contain_pget('Download-jdk-7u45-windows-x64.exe').with({
                                                                        'source' => 'https://mydomain/jdk-7u45-windows-x64.exe',
                                                                        'target' => 'C:\\temp'
                                                                    })
      should contain_package('Java SE Development Kit 7 Update 45 (64-bit)').with_ensure('present')
      should contain_windows_env('JAVA_HOME').with_value("C:\\Program Files\\Java\\jdk1.7.0_45")
    }
  end
end
