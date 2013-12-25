require 'spec_helper'

describe 'windows_java::jdk', :type => :define do

  let(:facts) {{:caller_module_name => 'spec',
                :osfamily           => 'Windows',
                :path               => 'C:/windows/system32',}}
  define 'when deploying with defaults' do
    let(:title){'Install JDK'}
    it{
      should contain_exec('Download-jdk-7u45-windows-x64.exe')
      should contain_package('Java SE Development Kit 7 Update 45 (64-bit)')
    }
  end
end
