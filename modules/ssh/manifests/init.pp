class ssh {
	file { '/etc/ssh/ssh_config':
		ensure => file,
		owner  => 'root',
		group  => 'root',
		mode   => '644',
		source => "puppet:///modules/$module_name/ssh_config",
	}
}
