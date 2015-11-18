#This class is used to mount the lustre partition
class lustre_mount{
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
}