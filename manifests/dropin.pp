# == Define systemd_coredump::dropin
#
# === Parameters:
# [*ensure*]
# [*dropin_title*]
# [*config*]
#
define systemd_coredump::dropin (
  Enum['present', 'absent'] $ensure = 'present',
  String $dropin_title              = $name,
  Optional[Hash] $config            = undef
) {
  $dropin_filename = regexpescape($dropin_title)
  unless empty($config) {
    file { "${dropin_filename}.conf":
      ensure  => $ensure,
      path    => "${systemd_coredump::dropin_config_dir}/${dropin_title}.conf",
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/coredump.conf.erb"),
    }
  }
}
