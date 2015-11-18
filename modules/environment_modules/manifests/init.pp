class environment_modules {
	package { "tclx8.4-dev":
		ensure => latest,
	}
	file { '/etc/profile.d/modules.sh':
		source => "puppet:///modules/$module_name/modules.sh",
		ensure => file,
		owner => 'root',
		group => 'root',
		mode => '644',
	}
	file { '/etc/skel/.bashrc':
		source => "puppet:///modules/$module_name/bashrc",
		ensure => file,
		owner => 'root',
		group => 'root',
		mode => '644',
	}
}
