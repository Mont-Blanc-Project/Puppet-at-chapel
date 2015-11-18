#These are packages requested by the users
class user_packages {
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
	package { "python-networkx":
		ensure => latest,
	}
	package { "python-pygraphviz":
		ensure => latest,
	}

	package { "binfmt-support":
		ensure => latest,
	}
	package { "clang":
		ensure => latest,
	}
	package { "dpkg-dev":
		ensure => latest,
	}
	package { "fakeroot":
		ensure => latest,
	}
	package { "fabric":
		ensure => latest,
	}
	package { "fontconfig-config":
		ensure => latest,
	}
	package { "git-man":
		ensure => latest,
	}
	package { "gperf":
		ensure => latest,
	}
	package { "libalgorithm-diff-perl":
		ensure => latest,
	}
	package { "libalgorithm-diff-xs-perl":
		ensure => latest,
	}
	package { "libalgorithm-merge-perl":
		ensure => latest,
	}
	package { "libclang-dev":
		ensure => latest,
	}
	package { "libclang1":
		ensure => latest,
	}
	package { "libcr0":
		ensure => latest,
	}
	package { "libdpkg-perl":
		ensure => latest,
	}
	package { "libffi-dev:armhf":
		ensure => latest,
	}
	package { "libfile-fcntllock-perl":
		ensure => latest,
	}
	package { "libfontconfig1:armhf":
		ensure => latest,
	}
	package { "libfreetype6:armhf":
		ensure => latest,
	}
	package { "liblinear-tools":
		ensure => latest,
	}
	package { "liblinear1":
		ensure => latest,
	}
	package { "libllvm3.3:armhf":
		ensure => latest,
	}
	package { "libltdl-dev:armhf":
		ensure => latest,
	}
	package { "libltdl7:armhf":
		ensure => latest,
	}
	package { "liblua5.1-0:armhf":
		ensure => latest,
	}
	package { "libobjc-4.7-dev:armhf":
		ensure => latest,
	}
	package { "libobjc4:armhf":
		ensure => latest,
	}
	package { "libopts25":
		ensure => latest,
	}
	package { "libpixman-1-0:armhf":
		ensure => latest,
	}
	package { "libsigsegv2":
		ensure => latest,
	}
	package { "libsqlite3-dev":
		ensure => latest,
	}
	package { "libssl-doc":
		ensure => latest,
	}
	package { "libtimedate-perl":
		ensure => latest,
	}
	package { "libxcb-render0:armhf":
		ensure => latest,
	}
	package { "libxcb-shm0:armhf":
		ensure => latest,
	}
	package { "libxrender1:armhf":
		ensure => latest,
	}
	package { "llvm":
		ensure => latest,
	}
	package { "llvm-3.3":
		ensure => latest,
	}
	package { "llvm-3.3-dev":
		ensure => latest,
	}
	package { "llvm-3.3-runtime":
		ensure => latest,
	}
	package { "llvm-dev":
		ensure => latest,
	}
	package { "llvm-runtime":
		ensure => latest,
	}
	package { "m4":
		ensure => latest,
	}
	package { "patch":
		ensure => latest,
	}
	package { "ttf-dejavu-core":
		ensure => latest,
	}
	package { "ruby-dev":
		ensure => latest,
	}
	package { "qemu":
		ensure => latest,
	}
}
