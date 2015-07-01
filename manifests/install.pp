define windows_java::install (
  $install_path,
  $source,
  $ensure = 'present',
  $package_name = $name,
){
  $_options =  ['/s',{ 'INSTALLDIR' => $install_path }]
  package{ $package_name:
    ensure          => $ensure,
    provider        => windows,
    source          => $source,
    install_options => $_options
  }
}