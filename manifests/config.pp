class tomcat::config {

  file { "/etc/${tomcat::tomcat_pkg}/server.xml":
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => $tomcat::tomcat_group,
    content => template('tomcat/server.xml.erb'),
  }

  file { "/var/lib/${tomcat::tomcat_pkg}/bin":
    ensure  => directory,
    mode    => '0755',
    owner   => 'root',
    group   => $tomcat::tomcat_group,
    require => Package['tomcat7'],
  }

  file { "${tomcat::defaults}/${tomcat::tomcat_pkg}":
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
    group   => $tomcat::tomcat_group,
    require => File ["/var/lib/${tomcat::tomcat_pkg}/bin"],
    content => template('tomcat/system-default-tomcat.erb'),
  }

  file { "/etc/${tomcat::tomcat_pkg}/tomcat-users.xml":
    ensure  => file,
    mode    => '0640',
    owner   => 'root',
    group   => $tomcat::tomcat_group,
    content => template('tomcat/tomcat-users.xml.erb'),
  }

  file { '/etc/logrotate.d/rotatelogs-tomcat-accesslog':
    ensure  => file,
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template('tomcat/rotatelogs-tomcat-accesslog.erb'),
  }

}
