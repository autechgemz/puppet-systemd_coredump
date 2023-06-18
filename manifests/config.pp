# Class == systemd_coredump::config
class systemd_coredump::config {

  file { $systemd_coredump::config_file:
    ensure  => present,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/coredump.conf.erb"),
  }

  unless empty($systemd_coredump::dropin_config_hash) {
    file { $::systemd_coredump::dropin_config_dir:
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      purge   => true,
      recurse => true,
    }
    create_resources('systemd_coredump::dropin', $systemd_coredump::dropin_config_hash)
  }
  else {
    file { $::systemd_coredump::dropin_config_dir:
      ensure  => absent,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      purge   => true,
      force   => true,
      recurse => true,
    }
  }

}
