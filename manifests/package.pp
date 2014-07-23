class tomcat::package {

  package { $tomcat::java_pkg:
    ensure => latest,
  }

  package { $tomcat::tomcat_pkg:
    ensure  => latest,
    require => Package[$tomcat::java_pkg],
  }

  package { $tomcat::tomcat_admin_pkg:
    ensure  => latest,
    require => Package[$tomcat::tomcat_pkg],
  }
}
