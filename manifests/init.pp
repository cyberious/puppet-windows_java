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
class windows_java ($version = '7u60',$ach = 'x64',$default = true,$ensure = present) {

  windows_java::jdk{$title:
    version => $version,
    default => $default,
    arch    => $arch,
  }
}
