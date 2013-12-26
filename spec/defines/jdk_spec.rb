require 'spec_helper'
describe 'windows_java', :type => :define do
  describe 'when deploying with defaults' do
    let(:title){'Install JDK'}
    it{
      #should contain_exec('Download-jdk-7u45-windows-x64.exe')
      should contain_package('Java SE Development Kit 7 Update 45 (64-bit)').with_ensure('present')
      #should contain_windows_env('JAVA_HOME')
    }
  end
end
