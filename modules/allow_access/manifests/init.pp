class allow_access ($users=["users"]) {
	package { "libpam0g-dev":
		ensure => latest
	}
	package { "exuberant-ctags":
		ensure => latest
	}
	file { '/etc/security/access.conf':
		ensure  => file,
		content => template("allow_access/access.erb"),
		require => [Package['exuberant-ctags'], Package['libpam0g-dev']],
	}
}
