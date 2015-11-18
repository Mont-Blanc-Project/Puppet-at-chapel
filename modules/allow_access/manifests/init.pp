#Allways the following users will have access to the machine [root,nagios,hca-admin,www-data]
#If $users is not specified all users have access to that machine, otherwise only the users that are inside the array will have acces to the machine
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
