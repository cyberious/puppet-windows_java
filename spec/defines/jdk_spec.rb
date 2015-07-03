require 'spec_helper'

describe 'windows_java::jdk' do
  let(:title) { '7u51' }
  let(:facts) { {:operatingsystem => 'windows', :architecture => 'x86_64', :windows_java_temp => 'C:\temp'} }
  describe 'when deploying with defaults' do
    let(:title) { '7u51' }
    describe 'defaults' do
      it {
        should contain_windows_java__download('Download-jdk-7u51-windows-x64.exe').with(
                   {
                       'source' => 'http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-windows-x64.exe',
                       'filename' => 'jdk-7u51-windows-x64.exe',
                       'temp_target' => 'C:\\temp'
                   })
      }
      it {
        should contain_windows_java__install('Java SE Development Kit 7 Update 51 (64-bit)').with(
                   {
                       'ensure' => 'present',
                       'source' => 'C:\temp\jdk-7u51-windows-x64.exe',

                   }
               )
      }
      it { should contain_windows_env('JAVA_HOME').with_value('C:\\Program Files\\Java\\jdk1.7.0_51') }
    end
  end
  describe 'install_name' do
    let(:params) { {:install_name => 'Custom Install Name'} }
    it { should contain_package('Custom Install Name').with_ensure('present') }
  end
  describe 'source' do
    let(:params) { {:source => 'http://mynetwork.net/jdk-7u51-x64.exe'} }
    it {
      should contain_windows_java__download('Download-jdk-7u51-x64.exe').with(
                 {
                     'source' => 'http://mynetwork.net/jdk-7u51-x64.exe',
                     'filename' => 'jdk-7u51-x64.exe'
                 }
             )
    }
  end
  describe 'version' do
    let(:title) { 'be meaningless' }
    let(:params) { {:version => '8u45'} }
    it {
      should contain_windows_java__download('Download-jdk-8u45-windows-x64.exe').with(
                 {
                     'source' => 'http://download.oracle.com/otn-pub/java/jdk/8u45-b15/jdk-8u45-windows-x64.exe',
                     'filename' => 'jdk-8u45-windows-x64.exe',
                     'temp_target' => 'C:\\temp'
                 })
    }
    it { should contain_package('Java SE Development Kit 8 Update 45 (64-bit)').with_ensure('present') }
    it { should contain_windows_env('JAVA_HOME').with_value('C:\\Program Files\\Java\\jdk1.8.0_45') }
  end

  describe 'build_number_hash' do
    let(:title) { '9u10' }
    let(:params) { {:build_number_hash => {'9u10' => 'b12', '9u5' => 'b2'}} }
    it {
      should contain_windows_java__download('Download-jdk-9u10-windows-x64.exe').with(
                 {
                     'source' => 'http://download.oracle.com/otn-pub/java/jdk/9u10-b12/jdk-9u10-windows-x64.exe',
                     'filename' => 'jdk-9u10-windows-x64.exe',
                     'temp_target' => 'C:\\temp'
                 })
    }
    it { should contain_package('Java SE Development Kit 9 Update 10 (64-bit)').with_ensure('present') }
    it { should contain_windows_env('JAVA_HOME').with_value('C:\\Program Files\\Java\\jdk1.9.0_10') }
  end

  context 'arch' do
    ['i586', 'i386', 'x86'].each { |arch|
      describe arch do
        let(:params) { {:arch => arch} }
        it {
          should contain_windows_java__download('Download-jdk-7u51-windows-i586.exe').with(
                     {
                         'source' => 'http://download.oracle.com/otn-pub/java/jdk/7u51-b13/jdk-7u51-windows-i586.exe',
                         'filename' => 'jdk-7u51-windows-i586.exe',
                         'temp_target' => 'C:\\temp'
                     })
        }
        it { should contain_package('Java SE Development Kit 7 Update 51').with_ensure('present') }
        it { should contain_windows_env('JAVA_HOME').with_value('C:\\Program Files (x86)\\Java\\jdk1.7.0_51') }
      end
    }
  end

end
