class dirtyfix {
	File {
		ensure => file,
		owner  => 'root',
		group  => 'root',
		mode   => '644',
	}
	file {
		"/etc/rc.local":
			source => "puppet:///modules/$module_name/rc.local",
			mode   => '755';
		"/opt/slurm/14.11.3/etc":
			ensure => directory,
			mode   => '755',
			owner  => 'slurm',
			group  => 'slurm';
		"/opt/slurm/14.11.3/etc/scripts":
			ensure => directory,
			mode   => '755',
			owner  => 'slurm',
			group  => 'slurm';
		"/opt/slurm/14.11.3/etc/scripts/epilog.sh":
			source => "puppet:///modules/$module_name/epilog.sh",
			mode   => '755',
			owner  => 'slurm',
			group  => 'slurm';
		"/opt/slurm/14.11.3/etc/scripts/prolog.sh":
			source => "puppet:///modules/$module_name/prolog.sh",
			mode   => '755',
			owner  => 'slurm',
			group  => 'slurm';
		"/opt/slurm/14.11.3/etc/slurm.conf":
			source => "puppet:///modules/$module_name/slurm.conf",
			owner  => 'slurm',
			group  => 'slurm';
		"/opt/slurm/14.11.3/etc/public.key":
			source => "puppet:///modules/$module_name/public.key";
		"/etc/munge/munge.key":
			source  => "puppet:///modules/$module_name/munge.key",
			owner   => 'munge',
			require => [User['munge'],Package['munge']],
			group   => 'munge',
			mode    => '400';
		"/etc/sysctl.d/10-tcp_tunning.conf":
			source => "puppet:///modules/$module_name/10-tcp_tunning.conf",
			mode   => '644',
			owner  => 'root',
			group  => 'root',
			notify => Exec['sysctl_update'];
		"/etc/environment":
			content => "PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/slurm/14.11.3/bin:/opt/slurm/14.11.3/sbin:\"\nMANPATH=\"/opt/slurm/14.11.3/share/man:\"",
			mode    => '644',
			owner   => 'root',
			notify  => Exec['sysctl_update'],
			group   => 'root';
			
	}
	sudo::conf {"slurm":
		priority => 10,
		content  => 'slurm ALL=(ALL) NOPASSWD: ALL',
	}
	group{ "slurm":
		ensure     => present,
		forcelocal => true,
		gid        => 998,
	}
	user { "slurm":
		ensure     => present,
		forcelocal => true,
		uid        => 999,
		gid        => 'slurm',
	}
	package {["openssl","libssl-dev","munge","libreadline-dev"]:
		ensure => present,
		require => User["slurm"],
	}
	group {"munge":
        	ensure => 'present',
        	system => true,
    	}
    	user {"munge":
        	ensure => 'present',
        	system => true,
        	gid    => "munge",
		require => User["slurm"],
    	}
	file {"munge_force":
		path  => "/etc/default/munge",
		ensure  => file,
		owner => 'root',
		group => 'root',
		mode  => '644',
		require => [Package['munge'],User['munge']],
		content => 'OPTIONS="--force"',
		notify  => Service['munge']
	}

	service { "munge":
    		ensure => running,
    		enable => true,
    		hasstatus => true,
		hasrestart => true,
		require => [File["munge_force"],File["/etc/munge/munge.key"]]
  	}
	file { '/etc/init.d/slurmd':
		source  => "puppet:///modules/$module_name/slurmd",
		ensure  => file,
		owner   => 'root',
		group   => 'root',
		mode    => '755',
		require => User['slurm'],
		notify  => Service['slurmd'],
	}
  	service { "slurmd":
		ensure => running,
		enable => true,
		hasstatus => true,
		hasrestart => true,
    		require => File['/etc/init.d/slurmd'],
	}
	exec { "sysctl_update":
		refreshonly => true,
		command     => "sysctl --system",
		path        => "/sbin:/usr/sbin:/bin:/usr/bin",
		user        => "root",
		group       => "root",
	}
	package { "python-networkx":
		ensure => latest,
	}
	package { "python-pygraphviz":
		ensure => latest,
	}
}
