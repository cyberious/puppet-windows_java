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
define windows_java::jdk  (
  $ensure            = 'present',
  $version           = $name,
  $arch              = $::architecture,
  $build_number_hash = undef,
  $cookie_string     = undef,
  $default           = true,
  $install_name      = undef,
  $install_path      = undef,
  $source            = undef,
  $temp_target       = $::windows_java_temp,) {
  include windows_java::params

  $_splitversion = split($version,'[uU]')
  $_major = $_splitversion[0]
  $_update =  count($_splitversion) ? {
    2       => $_splitversion[1],
    default => ''
  }

  $_build_hash = pick($build_number_hash,$::windows_java::params::build_numbers_hash)
  $_cookie_string = pick($cookie_string, $::windows_java::params::cookie_string)

  $_arch_version = $arch ? {
    /^(x86|i586|i386)$/ => 'i586',
    /x(86_|)64/         => 'x64',
    default             => fail('Must be one of i586 or x64'),
  }

  if $install_name == undef {
    $_installBase = "${::windows_java::params::jdk_base_install_name} ${_major}"
    $_installUpdate =  $_update ?{
      /\d+/   => " Update ${_update}",
      default => '',
    }
    $_installArch =  $_arch_version ? {
      'x64'   => ' (64-bit)',
      default => '',
    }
    $_installName = "${_installBase}${_installUpdate}${_installArch}"
  } else {
    $_installName = $install_name
  }

  if has_key($_build_hash, $version) {
    $_build_number = join([$version, '-', $_build_hash[$version]],'')
  }
  elsif $source {
    $_build_number = ''
  }
  else {
    fail("Unable to determine version ${version} from build_numbers_hash")
  }

  if($ensure == 'present'){
    if $source == undef {
      $_filename = "jdk-${version}-windows-${_arch_version}.exe"
      $_remote_source = "${windows_java::params::root_url}/${_build_number}/${_filename}"
    } else{
      $_remote_source = $source
      $_filename = filename($_remote_source)
    }
  ##
  # Install Paths
  #
  ##
    if $::architecture == 'x86_64' and $_arch_version == 'i586'{
      $_base_install_path = 'C:\Program Files (x86)\Java'
    } else{
      $_base_install_path = 'C:\Program Files\Java'
    }
    $_installPath = $install_path ? {
      undef   => "${_base_install_path}\\jdk1.${_major}.0_${_update}",
      default => $install_path,
    }

    $_tempLocation = "${temp_target}\\${_filename}"

    windows_java::download { "Download-${_filename}":
      source      => $_remote_source,
      filename    => $_filename,
      temp_target => $temp_target,
    }->
    windows_java::install{ $_installName:
      ensure       => $ensure,
      source       => $_tempLocation,
      install_path => $_installPath,
    }
    validate_bool($default)
    if($default == true){
      class{ 'windows_java::java_home':
        install_path => $_installPath,
        require      => Windows_java::Install[$_installName] }
    }
  } else{
    package{ $_installName:
      ensure   => $ensure,
      provider => windows,
    }
  }
}
