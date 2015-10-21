class ldap {
  package { "libpam-ldapd":
  	ensure => latest,
  }->
  package { "libnss-ldapd":
  	ensure => latest,
  }->
  package { "ldap-auth-config":
  	ensure => latest,
  }->
  package { "ldap-auth-client":
  	ensure => latest,
  }->
  package { "ldap-utils":
  	ensure => latest,
  }->
  package { "nscd":
  	ensure => latest,
  }->
  package { "nslcd":
  	ensure => latest,
  }->
  file { "/etc/nslcd.conf":
	ensure => file,
	owner => 'root',
	group => 'nslcd',
	mode => '640',
	source => "puppet:///modules/ldap/nslcd.conf",
    	require => [Package['libpam-ldapd'],Package['libnss-ldapd']],
   	notify => [Service['nslcd'],Service['nscd']]
  }-> 	
  file { "/etc/nsswitch.conf":
	ensure => file,
	owner => 'root',
	group => 'root',
	mode => '644',
	source => "puppet:///modules/ldap/nsswitch.conf",
  	notify => [Service['nslcd'],Service['nscd']]
  }->	
  file { "/etc/pam.d":
	ensure  => directory,
	recurse => true,
	owner   => 'root',
	group   => 'root',
	mode    => '644',
	source  => "puppet:///modules/ldap/pam.d",
  	notify  => [Service['nslcd'],Service['nscd']]
  }->	
  file { "/etc/auth-client-config/profile.d":
	ensure  => directory,
	recurse => true,
	owner   => 'root',
	group   => 'root',
	mode    => '644',
	source  => "puppet:///modules/ldap/auth",
  	notify  => [Service['nslcd'],Service['nscd']]
  }-> 	
  file { "/etc/ldap.conf":
	ensure => file,
	owner => 'root',
	group => 'root',
	mode => '644',
	source => "puppet:///modules/ldap/ldap.conf",
    	require => [Package['libpam-ldapd'],Package['libnss-ldapd']],
    	notify => [Service['nslcd']]
  }-> 	
  service {"nscd":
	ensure => running,
	enable => true,
	hasstatus => true,
	hasrestart => true,
    	require => [File['/etc/ldap.conf']],
  }->
  service {"nslcd":
	ensure => running,
	enable => true,
	hasstatus => true,
	hasrestart => true,
    	require => [File['/etc/ldap.conf']],
  }
}
