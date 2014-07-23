class tomcat (
  $port            = $tomcat::params::port,
  $ssl_port        = $tomcat::params::ssl_port,
  $ssl_enabled     = $tomcat::params::ssl_enabled,
  $max_threads     = $tomcat::params::max_threads,
  $keystore_file   = $tomcat::params::keystore_file,
  $keystore_pass   = $tomcat::params::keystore_pass,
  $key_alias       = $tomcat::params::key_alias,
  $java_opts       = $tomcat::params::java_opts,
  $setenv          = $tomcat::params::setenv,
  $remoteipheader  = $tomcat::params::remoteipheader,
  $internalproxies = $tomcat::params::internalproxies,
  $tomcat_managers = $tomcat::params::tomcat_managers,
) inherits tomcat::params {

  validate_hash($setenv)
  validate_string($keystore_file, $keystore_pass, $key_alias)
  validate_array($java_opts)
  validate_array($tomcat_managers)

  if $::osfamily == 'Debian' {
    $tomcat_pkg       = 'tomcat7'
    $tomcat_admin_pkg = 'tomcat7-admin'
    $java_pkg         = 'openjdk-7-jre-headless'
    $defaults         = '/etc/default'
    $tomcat_group     = $tomcat_pkg
    $tomcat_user      = $tomcat_pkg
  } elsif $::osfamily == 'RedHat' {
    $tomcat_pkg       = 'tomcat6'
    $tomcat_admin_pkg = 'tomcat6-admin-webapps'
    $java_pkg         = 'java-1.5.0-gcj'
    $defaults         = '/etc/sysconfig'
    $tomcat_group     = 'tomcat'
    $tomcat_user      = 'tomcat'
  }  else {
    fail('Your operating system isn\'t supported by this tomcat module.')
  }


  include tomcat::package
  include tomcat::config
  include tomcat::service

  anchor { 'tomcat_start': } ->
  Class [ 'tomcat::package' ] ->
  Class [ 'tomcat::config' ] ->
  Class [ 'tomcat::service' ] ->
  anchor { 'tomcat_end': }

}
