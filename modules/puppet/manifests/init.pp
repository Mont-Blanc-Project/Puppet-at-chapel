class puppet {
	include stdlib
	$nom = $::hostname
	$array = split($nom,'-')
	$blade = $array[1]
	$sdb = $array[2]
	$num = ($blade - 1) * 15 + $sdb - 1
	$time = $num * 10
	$weekday = $time / 1440
	$time2 = $time - $weekday * 1440
	$hour = $time2 / 60
	$minute = $time2 % 60
	notify{"hostname = W=$weekday H=$hour M=$minute":}
	file {"/etc/puppet/puppet.conf":
		ensure => file,
		owner  => 'puppet',
		group  => 'puppet',
		source => "puppet:///modules/puppet/puppet.conf",
		mode   => '644',
	}
}
