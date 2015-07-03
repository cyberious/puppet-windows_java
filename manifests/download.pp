define windows_java::download (
  $filename,
  $source,
  $temp_target,
  $cookie_string = $::windows_java::params::cookie_string,
){
  assert_private()
  Exec{
    tries     => 3,
    try_sleep => 30,
    timeout   => 500,
  }
  $agent = 'Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko'
  $header_hash = {
    'user-agent' => $agent,
    'Cookie'     => $cookie_string
  }
  debug("Downloading from source ${source} to ${temp_target}")
  info("Downloading file ${filename}")
  pget{ $name:
    source         => $source,
    target         => $temp_target,
    targetfilename => $filename,
    headerHash     => $header_hash,
  }
}