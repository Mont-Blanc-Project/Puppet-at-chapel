class basenode{
	include ssh
	include snmp
	include sudo
	include admin_users
	class {'ntp':
	  servers => [ 'time.mont.blanc' ],
	}
	include lustre_mount
	include environment_modules

	include basic_packages
	include user_packages
	class { 'locales':
	  default_locale => 'en_US.UTF-8',
	  locales        => ['en_US.UTF-8 UTF-8', 'es_ES.UTF-8 UTF-8'],
	}
	include ldap
	include dirtyfix
	include slurm
}

define multiple_sudo{
	sudo::conf {"$title":
	    priority => 20,
	    content  => "$title ALL=(ALL) NOPASSWD: ALL"
	}
}

class give_node($user){
	class {'allow_access':
		users => $user
	}
	multiple_sudo {$user:}
}
#vishal nodes
node /^mb-(4[8-9])-([1-9]|1[0-5])\.mont\.blanc$/ {
	include basenode
	package{"bridge-utils":
		ensure => latest,
	}
	file {"/etc/network/interfaces":
		ensure  => file,
		owner   => 'root',
		group   => 'root',
		content => '# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet manual

auto br100
iface br100 inet dhcp
bridge_ports eth0
',
		mode => '644'
	}
	#	include puppet
}

node /^mb-([1-9]|[1-6]\d)-([1-9]|1[0-5])\.mont\.blanc$/ {
	include basenode
	#	include puppet
}

node /^mb-login-([1-9]|1[0-5])\.mont\.blanc$/ {
	include basenode
}

node 'mb-30-13.mont.blanc' {
	include puppet
	include basenode
	class { 'give_node':
		user => ['fzyulkyarov']
	}
}
