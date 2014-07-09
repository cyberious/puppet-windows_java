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
#   If this is the default Java install and will accordingly assign
#   to JAVA_HOME and Environment Variable Path defaults to true
# [*source*]
#   URL to download the msi or executable from can be ftp as well as http
# [*cookie_string*]
#   String to bypass the accept license from Oracle
# [*ensure*]
#   Present or absent
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
define windows_java::jdk(
  $ensure           = 'present',
  $version          = '7u51',
  $arch             = 'x64',
  $default          = true,
  $install_name     = undef,
  $source           = undef,
  $install_path     = undef,
  $jre_install_path = undef,
  $cookie_string    = 'oraclelicense=accept-securebackup-cookie;gpw_e24=http://edelivery.oracle.com',
  $temp_target      = 'C:\temp' ) {



  $windows_java = hiera('windows_java')
  $version_info = $windows_java[$version]
  if $::architecture in ['x86','i386','i586'] and $arch == "x64"{
    #warn("Unable to install to install a 64 bit version of Java on a 32 bit system, installing 32 instead")
    $arch_info = $version_info['i586']
  }else{
    $arch_info = $version_info[$arch]
  }
  if ! $install_name {
    $installName = $arch_info['install_name']
  }else{
    $installName = $install_name
  }

  if($ensure == 'present'){
    validate_bool($default)
    if ! $source {
      $root_url = $windows_java['root_url']
      if $source =~ /^puppet:\/\/\/.+/ {
        $build_number = ""
      }else{
        $build_number = $version_info['build_number']
      }
      $file_name = $arch_info['file_name']
      $remoteSource = "${root_url}/${build_number}/${file_name}"
    }else{
      $remoteSource = $source
    }
    info("Downloading from ${remoteSource}")
    if ! $install_path {
      $installPath = $arch_info['install_path']
    }else{
      $installPath = $install_path
    }
    if ! $jre_install_path {
      $jreInstallPath = $arch_info['jre_install_path']
    }else{
      $jreInstallPath = $jre_install_path
    }
    file{$temp_target:
      ensure => directory,
    }

    $filename = filename($remoteSource)

    $tempLocation = "${temp_target}\\${filename}"

    Exec{
      tries     => 3,
      try_sleep => 30,
      timeout   => 500,
    }
    $agent = 'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko'
    debug("Downloading from source ${remoteSource} to ${temp_target}")
    pget{"Download-${filename}":
      require     => File[$temp_target],
      source      => $remoteSource,
      target      => $temp_target,
      headerHash  => {
        'user-agent' => $agent,
        'Cookie'     => $cookie_string }
    }

    package{$installName:
      ensure          => $ensure,
      provider        => windows,
      source          => $tempLocation,
      install_options => ['/s',{'INSTALLDIR'=> $installPath}],
      require         => Pget["Download-${filename}"]
    }

    if($default == true){
      windows_env{'JAVA_HOME':
        ensure    => present,
        value     => $installPath,
        mergemode => clobber,
        require   => Package[$installName];
      }
      windows_env{'PATH=%JAVA_HOME%\bin':}
    }
  }else{
    package{$installName:
      ensure          => $ensure,
      provider        => windows,
    }
  }
}
