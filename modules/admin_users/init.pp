#this class is used to specify all the users that have root privileges
class admin_users{
	sudo::conf {'uriviba':
	  priority => 10,
	  content  => 'uriviba ALL=(ALL) NOPASSWD: ALL',
	}
	sudo::conf {'nrajovic':
	  priority => 20,
	  content  => 'nrajovic ALL=(ALL) NOPASSWD: ALL',
	}
	sudo::conf {'druiz':
	  priority => 10,
	  content  => 'druiz ALL=(ALL) NOPASSWD: ALL',
	}
	sudo::conf {'fmantovani':
	  priority => 10,
	  content  => 'fmantovani ALL=(ALL) NOPASSWD: ALL',
	}
}