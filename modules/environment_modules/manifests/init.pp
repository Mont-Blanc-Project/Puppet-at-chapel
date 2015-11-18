class modulees {
	package { "tclx8.4-dev":
		ensure => latest,
	}
	file { '/etc/profile.d/modules.sh':
		source => "puppet:///modules/modulees/modules.sh",
		ensure => file,
		owner => 'root',
		group => 'root',
		mode => '644',
	}
	file { '/etc/skel/.bashrc':
		source => 'puppet:///modules/modulees/bashrc',
		ensure => file,
		owner => 'root',
		group => 'root',
		mode => '644',
	}
}
