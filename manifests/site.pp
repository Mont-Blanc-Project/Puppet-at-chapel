class basenode{
	include sudo
	include ssh
	include snmp
	sudo::conf {'uriviba':
	  priority => 10,
	  content  => 'uriviba ALL=(ALL) NOPASSWD: ALL',
	}
	sudo::conf {'nrajovic':
	  priority => 20,
	  content  => 'nrajovic ALL=(ALL) NOPASSWD: ALL',
	}
	sudo::conf {'druiz':
	  priority => 10,
	  content  => 'druiz ALL=(ALL) NOPASSWD: ALL',
	}
	sudo::conf {'fmantovani':
	  priority => 10,
	  content  => 'fmantovani ALL=(ALL) NOPASSWD: ALL',
	}
	sudo::conf {'mbenito':
	  priority => 20,
	  content  => 'mbenito ALL=(ALL) NOPASSWD: ALL',
	}
	package {"time":
	  ensure => present
	}
	include dirtyfix
	class {'ntp':
	  servers => [ 'time.mont.blanc' ],
	}
	file {"/lustre":
		ensure => directory,
		owner  => 'root',
		group  => 'root',
		mode   => '755',
	}
	file {"/home":
		ensure  => link,
		force   => true,
		target  => '/lustre/home',
		require => File['/lustre']
	}
	file {"/apps":
		ensure => link,
		target => '/lustre/apps',
		require => File['/lustre']
	}
	mount { "/lustre":
		ensure  => mounted,
		device  => "192.168.0.4@tcp:/lustremb",
		fstype  => 'lustre',
		options => 'defaults,_netdev,flock',
		require => File['/lustre']
	}
	include modulees
	file { '/dev/mali0' :
	  owner => 'root',
	  group => 'root',
	  mode  => '666',
	}
	include random_packages
	include basic_packages
	class { 'locales':
	  default_locale => 'en_US.UTF-8',
	  locales        => ['en_US.UTF-8 UTF-8', 'es_ES.UTF-8 UTF-8'],
	}
	include ldap
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

#node 'mb-56-1.mont.blanc' {
#	include puppet
#	include basenode
#	class { 'give_node':
#		user => ["evallejo","mbenito"]
#	}
#}
#node 'mb-56-2.mont.blanc' {
#	include puppet
#	include basenode
#	class { 'give_node':
#		user => ["evallejo","mbenito"]
#	}
#}
#node 'mb-57-1.mont.blanc' {
#	include puppet
#	include basenode
#	class { 'give_node':
#		user => ["evallejo","mbenito"]
#	}
#}
#node 'mb-57-2.mont.blanc' {
#	include puppet
#	include basenode
#	class { 'give_node':
#		user => ["evallejo","mbenito"]
#	}
#}

node 'mb-30-13.mont.blanc' {
	include puppet
	include basenode
	class { 'give_node':
		user => ['fzyulkyarov']
	}
}
