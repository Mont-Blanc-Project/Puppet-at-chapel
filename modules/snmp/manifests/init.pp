class snmp {
	file { '/etc/snmp/snmpd.conf':
		ensure => file,
		owner  => 'root',
		group  => 'root',
		mode   => '600',
		source => "puppet:///modules/$module_name/snmpd.conf",
		notify => Service['snmpd']
	}
	package { 'snmpd':
		ensure => latest,
	}
	service { 'snmpd':
		ensure => running,
		hasrestart => true,
		hasstatus => true,
	}
}
