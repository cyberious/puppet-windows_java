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
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { jdk:
#    
#  }
#
# === Authors
#
# Author Name tfields@commercehub.com
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#
class windows_java::jdk(
	$version ,
	$arch = 'i586',
	$installName = 'Java(TM) SE Development Kit 6 Update 21',
	$default = 'true',
	$sourceDir = '\\mario\downloads\jdk') {
  
  $installDir = "D:\Java\jdk-${version}-${arch}"

  package{$installName:
  	provider        => windows,
        ensure          => installed,
        source          => "${sourceDir}\jdk-${version}-windows-${arch}.exe",
        install_options => ['/s',{'INSTALLDIR'=> $installDir}]
  }

  if($default){
    windows_env{'JAVA_HOME':
        ensure          => present,
        value           => $installDir,
        mergemode       => clobber,
	require		=> Package[$installName];
    }
    windows_env{'PATH=%JAVA_HOME%\bin':}
  }
}
