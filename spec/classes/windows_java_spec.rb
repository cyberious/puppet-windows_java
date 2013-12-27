require 'spec_helper'
require 'rspec-puppet'

describe 'windows_java' do

  let(:title) {'install jdk'}
  it {
    should contain_exec('Download-jdk-7u45-windows-x64.exe').with_command("$clnt = New-Object System.Net.WebClient;$clnt.Headers.Add('user-agent','Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko');\$clnt.Headers.Add('Cookie','gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk-7u3-download-1501626.html;');$clnt.DownloadFile('http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-windows-x64.exe','C:\\temp\\jdk-7u45-windows-x64.exe')")
    should contain_package('Java SE Development Kit 7 Update 45 (64-bit)').with_ensure('present')
    should contain_windows_env('JAVA_HOME').with_value("C:\\Program Files\\Java\\jdk1.7.0_45")
  }

end