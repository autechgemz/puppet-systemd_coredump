# == Class: systemd_coredump::install
class systemd_coredump::install {
  package { $systemd_coredump::package_name:
    ensure          => $systemd_coredump::package_ensure,
    install_options => $systemd_coredump::install_options,
  }
}
