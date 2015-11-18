#This class is used to all the fixes that belong to no particular class
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
		"/etc/sysctl.d/10-tcp_tunning.conf":
			source => "puppet:///modules/$module_name/10-tcp_tunning.conf",
			notify => Exec['sysctl_update'];
		"/dev/mali0":
			mode  => '666';
	}
	exec { "sysctl_update":
		refreshonly => true,
		command     => "sysctl --system",
		path        => "/sbin:/usr/sbin:/bin:/usr/bin",
		user        => "root",
		group       => "root",
	}
}
