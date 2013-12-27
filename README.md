#Windows Oracle Java module for Puppet
[![Build Status](https://travis-ci.org/cyberious/puppet-windows_java.png?branch=master)](https://travis-ci.org/cyberious/puppet-windows_java)

Downloads and installs Oracle Java or any other version of Java that you may require

##Usage

    class{'windows_java':}

    windows_java::jdk{'JDK 7u45':
        install_name = 'Java SE Development Kit 7 Update 45 (64-bit)',
        ensure      = 'present',
        install_path= "c:\\java\\jdk1.7.0_45",
        source      = "http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-windows-x64.exe"
    }

