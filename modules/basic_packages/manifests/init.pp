class basic_packages {
	package { "screen":
		ensure => latest,
	}
	package { "aptitude":
		ensure => latest,
	}
	package { "vim":
		ensure => latest,
	}
	package { "bash-completion":
		ensure => latest,
	}
	package { "command-not-found":
		ensure => latest,
	}
	package { "git":
		ensure => latest,
	}
	package { "htop":
		ensure => latest,
	}
	package { "molly-guard":
		ensure => latest,
	}
	package { "mlocate":
		ensure => latest,
	}
	package { "gdb":
		ensure => latest,
	}
	package { "zsh":
		ensure => latest,
	}
  	package { "bc":
  		ensure => latest,
  	}
  	package { "tree":
  		ensure => latest,
  	}
	#Not so basic
	package { "memtester":
		ensure => latest,
	}
	package { "libqt4-dev":
		ensure => latest,
  	}
	package { "libqt4-core":
		ensure => latest,
	}
	package { "graphviz":
		ensure => latest,
	}
	package { "graphviz-dev":
		ensure => latest,
	}
	package { "libpyside-dev":
		ensure => latest,
	}
	package { "libpyside1.2":
		ensure => latest,
	}
	package { "pyside-tools":
		ensure => latest,
	}
	package { "python2.7":
		ensure => latest,
	}
	package { "python2.7-dev":
		ensure => latest,
	}
	package { "python-dev":
		ensure => latest,
	}
}
