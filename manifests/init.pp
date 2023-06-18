# Class == systemd_coredump
#
# Requires:
# puppetlabs-stdlib
#
# Parameters:
# [*ensure*]
# [*package_name*]
# [*package_ensure*]
# [*install_options*]
# [*config_file*]
# [*config_hash*]
# [*dropin_config_dir*]
# [*dropin_config_hash*]
#
class systemd_coredump (
  Enum['present','absent'] $ensure,
  Array[String] $package_name,
  String $package_ensure,
  Array $install_options,
  Stdlib::Absolutepath $config_file,
  Optional[Hash] $config_hash,
  Stdlib::Absolutepath $dropin_config_dir,
  Optional[Hash] $dropin_config_hash,
) {
  if ($facts['os']['name'] == 'Ubuntu' and versioncmp($facts['os']['release']['major'],'20',true) < 0) {
    fail('Unsupport operating system.')
  }
  contain systemd_coredump::install
  contain systemd_coredump::config
  Class['systemd_coredump::install']
  -> Class['systemd_coredump::config']
}
