# == Class: jdk
#
# Full description of class jdk here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*install_name*]
#   The name as it will appear in the Add or Remove Programes
# [*default*]
#   If this is the default Java install and will accordingly assign to JAVA_HOME and Environment Variable Path
#   defaults to true
# [*source*]
#   URL to download the msi or executable from can be ftp as well as http
# [*cookie_string*]
#   String to bypass the accept license from Oracle
# [*ensure*]
#   Present or absent
#
# [*install_path*]
#   The path to install java to, defaults to c:\Program Files\Java\jdk1.7.0_45
# === Examples
#
#  windows_java::jdk{'JDK 7u45':
#     install_name = 'Java SE Development Kit 7 Update 45 (64-bit)',
#     ensure      = 'present',
#     install_path= "c:\\java\\jdk1.7.0_45"
#  }
#
# === Authors
#
# Author Name Travis Fields
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
define windows_java::jdk (
	$install_name    = 'Java SE Development Kit 7 Update 45 (64-bit)',
	$default        = 'true',
	$source         = 'http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-windows-x64.exe',
    $install_path   = "C:\\Program Files\\Java\\jdk1.7.0_45",
    $ensure         = "present",
    $cookie_string  = "gpw_e24=http%3A%2F%2Fwww.oracle.com%2Ftechnetwork%2Fjava%2Fjavase%2Fdownloads%2Fjdk-7u3-download-1501626.html;")
{

  if($ensure == "present"){
    $filename = filename($source)

    $tempLocation = "C:\\temp\\${filename}"
    $c1 = '$clnt = New-Object System.Net.WebClient;'
    $c2 = $source ? {
      /oracle\.com/ => "\$clnt.Headers.Add('user-agent','Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko');\$clnt.Headers.Add('Cookie','${cookie_string}');",
      default => "",
    }
    $c3 = "\$clnt.DownloadFile('${source}','${tempLocation}')"

    exec{'Download-JDK':
      provider  => powershell,
      path  => $::path,
      command   => "${c1}${c2}${c3}",
      unless    => "if(Test-Path -Path \"${tempLocation}\" ){ exit 0 }else{exit 1}",
      logoutput => true
    }

    package{$install_name:
  	  provider        => windows,
      ensure          => "present",
      source          => $tempLocation,
      install_options => ['/s',{'INSTALLDIR'=> $install_path}],
      require => Exec['Download-JDK']
    }

    if($default){
      windows_env{'JAVA_HOME':
        ensure          => present,
        value           => $install_path,
        mergemode       => clobber,
	    require		=> Package[$install_name];
      }
      windows_env{'PATH=%JAVA_HOME%\bin':}
    }
  }else{
    package{$install_name:
      provider        => windows,
      ensure          => $ensure,
    }
  }
}
