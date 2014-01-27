#Windows Oracle Java module for Puppet
[![Build Status](https://travis-ci.org/cyberious/puppet-windows_java.png?branch=master)](https://travis-ci.org/cyberious/puppet-windows_java)

Downloads and installs Oracle Java or any other version of Java that you may require

##Usage

    class{'windows_java':}


Using the module_data we can simply provide hiera backend data to allow for more simplistic version updating.

    windows_java::jdk{'Install 7u51':
        version => '7u51',
    }


If you want to declare everything you can

    windows_java::jdk{'JDK 7u45':
        install_name = 'Java SE Development Kit 7 Update 45 (64-bit)',
        ensure      = 'present',
        install_path= "c:\\java\\jdk1.7.0_45",
        source      = "http://download.oracle.com/otn-pub/java/jdk/7u45-b18/jdk-7u45-windows-x64.exe"
    }


## Hiera Backend

You can override the backend if you have paths that you prefer including source

    windows_java: {
        root_url: "puppet:///extra_files/jdk/
        7u11: {
            build_number: "",
            x64: {
                install_path: "C:\\Java\\jdk1.7.0_11",
                file_name: "mycustom-jdk-file.exe"
            }

        }
    }
