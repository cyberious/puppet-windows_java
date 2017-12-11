# == Class: windows_java
#
# Full description of class windows_java here.
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
# === Examples
#
#  class { 'windows_java':
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
class windows_java (
  $ensure            = 'present',
  $version           = '8u45',
  $arch              = $::architecture,
  $build_number_hash = undef,
  $cookie_string     = undef,
  $default           = true,
  $install_name      = undef,
  $install_path      = undef,
  $source            = undef,
  $temp_target       = $::windows_java_temp,
) {
  windows_java::jdk{ "install_java_${version}":
    ensure            => $ensure,
    version           => $version,
    arch              => $arch,
    build_number_hash => $build_number_hash,
    cookie_string     => $cookie_string,
    default           => $default,
    install_name      => $install_name,
    install_path      => $install_path,
    source            => $source,
    temp_target       => $::windows_java_temp,
  }
}
