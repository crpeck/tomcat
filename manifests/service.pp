class tomcat::service {

  service { $tomcat::tomcat_pkg:
    ensure => running,
    enable => true,
  }

}
