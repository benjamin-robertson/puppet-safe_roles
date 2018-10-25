#@PDQTest

file { "/tmp/safe_role.txt":
  ensure  => file,
  content => $facts['safe_role'],
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}

file { "/tmp/safe_pp_role.txt":
  ensure  => file,
  content => $facts['safe_pp_role'],
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}

file { "/tmp/safe_os.txt":
  ensure  => file,
  content => String($facts['safe_os']),
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}