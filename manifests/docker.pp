# Class: yumrepos::docker
#
# Installs the EPEL yum repository.
#
class yumrepos::docker (
  $docker_url = $yumrepos::params::docker_url,
  $docker_enabled = $yumrepos::params::docker_enabled,
  $docker_gpgcheck = $yumrepos::params::docker_gpgcheck,
  $docker_includepkgs = $yumrepos::params::docker_includepkgs,
  $docker_exclude = $yumrepos::params::docker_exclude,
) inherits yumrepos::params {

  file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-docker":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => "puppet:///modules/yumrepos/etc/pki/rpm-gpg/RPM-GPG-KEY-docker",
  }

  yumrepo { 'docker':
    descr       => 'Docker',
    baseurl     => $docker_url,
    enabled     => $docker_enabled,
    gpgcheck    => $docker_gpgcheck,
    includepkgs => $docker_includepkgs,
    exclude     => $docker_exclude,
    gpgkey      => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-docker",
    require     => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-docker"],
  }

  yumrepos::rpm_gpg_key { "docker":
      path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-docker",
  }

}
