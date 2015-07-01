class windows_java::java_home ($install_path,){
  assert_private()
  windows_env{ 'JAVA_HOME':
    ensure    => present,
    value     => $install_path,
    mergemode => clobber,
  }
  windows_env{ 'PATH=%JAVA_HOME%\bin': }
}