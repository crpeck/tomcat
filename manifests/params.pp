class tomcat::params {
  $port           = '8080'

  $ssl_port       = '8443'
  $ssl_enabled    = false

  $max_threads     = '200'

  $java_opts      = [ '-Xms128M',
                      '-Xmx256M' ]
  $remoteipheader = false
  $internalproxies = '10\.80\.160\.\d{1,3}'
  # Variables must be named in lower case
  # They will be uppercased in the environment (limitation of ruby hashes)
  $setenv         = { my_tomcat_home => '/var/lib/tomcat', }
}
