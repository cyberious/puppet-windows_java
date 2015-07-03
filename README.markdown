# windows_java

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with windows_java](#setup)
    * [What windows_java affects](#what-windows_java-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with windows_java](#beginning-with-windows_java)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
6. [Limitations](#limitations)
7. [Development](#development)

## Overview

This tool is for downloading and installing Oracle Java

## Module Description

This module can be used to install one or multiple JDK versions from Oracle

## Setup

### What windows_java affects

* Installs/removes multiple versions of Oracle Java
* Updates PATH and JAVA_HOME if default set true

### Beginning with windows_java

####Install Oracle JDK Version 8u45
~~~puppet
 include 'windows_java'
~~~

 This will install Oracle JDK version 8 update 45

## Usage

####Install JDK 7u51 and not as default
~~~puppet
windows_java::jdk{'7u51':
  default => false,
}
~~~

####Install JDK 7u51 non default location
~~~puppet
windows_java::jdk{'7u51':
  install_path => 'G:\java\jdk7u51',
  default      => false,
}
~~~

## Reference

### Classes

#### `windows_java`

* `ensure`: *Optional.* Whether to install or remove the version
* `version`: *Optional.* What version of the jdk to install.  Defaults to '8u45'
* `arch`: *Optional.* What architecture you want to install, Valid options are 'x64','i586'.  Default is: `$::architecture`
* `default`: *Optional.* Whether to update and set the JAVA_HOME and include in PATH environment variables

### Types

#### `windows_java::jdk`

* `ensure`: *Optional.* Whether to install or remove the version
* `version`: *Optional.* What version of the jdk to install.  Defaults to '8u45'
* `arch`: *Optional.* What architecture you want to install, Valid options are 'x64','i586'.  Default is: `$::architecture`
* `build_number_hash`: *Optional.* Build number lookup hash for looking up url build numbers `{'8u45' => 'b15' }`
* `cookie_string`: *Optional.* The cookie string required to download the JDK from Oracle
* `default`: *Optional.* Whether to update and set the JAVA_HOME and include in PATH environment variables
* `install_name`: *Optional.* The package name but is inferred by version being installed
* `install_path`: *Optional.* The location to install JDK to.
* `source`: *Optional.* Alternate source to download from, can be puppet:// http(s):// url
* `temp_target`: *Optional.* Temp target for downloading the JDK installer to, defaults to ENV['TEMP']

