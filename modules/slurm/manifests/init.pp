#Copyright (c) 2015, Barcelona Supercomputing Center 
#All rights reserved.
#
#Redistribution and use in source and binary forms, with or without
#modification, are permitted provided that the following conditions are met:
#
#1. Redistributions of source code must retain the above copyright notice, this
#   list of conditions and the following disclaimer.
#2. Redistributions in binary form must reproduce the above copyright notice,
#   this list of conditions and the following disclaimer in the documentation
#   and/or other materials provided with the distribution.
#
#THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
#ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
#The views and conclusions contained in the software and documentation are those
#of the authors and should not be interpreted as representing official policies,
#either expressed or implied, of the FreeBSD Project.

#This class is used to install and configure slurm
class slurm {
	File {
		ensure => file,
		owner  => 'slurm',
		group  => 'slurm',
		mode   => '755',
	}
	file {
		"/opt/slurm/14.11.3/etc":
			ensure => directory;
		"/opt/slurm/14.11.3/etc/scripts":
			ensure => directory;
		"/opt/slurm/14.11.3/etc/scripts/epilog.sh":
			source => "puppet:///modules/$module_name/epilog.sh";
		"/opt/slurm/14.11.3/etc/scripts/prolog.sh":
			source => "puppet:///modules/$module_name/prolog.sh";
		"/opt/slurm/14.11.3/etc/slurm.conf":
			mode   => '644',
			source => "puppet:///modules/$module_name/slurm.conf";
		"/opt/slurm/14.11.3/etc/public.key":
			mode   => '644',
			source => "puppet:///modules/$module_name/public.key";
		"/etc/munge/munge.key":
			source  => "puppet:///modules/$module_name/munge.key",
			owner   => 'munge',
			require => [User['munge'],Package['munge']],
			group   => 'munge',
			mode    => '400';
		"/etc/environment":
			content => "PATH=\"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/opt/slurm/14.11.3/bin:/opt/slurm/14.11.3/sbin:\"\nMANPATH=\"/opt/slurm/14.11.3/share/man:\"",
			mode    => '644',
			owner   => 'root',
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
}
