# Class: yumrepos::openscap
#
# Installs the Openscap yum repository.
#
class yumrepos::openscap (
  $openscap_url                 = $yumrepos::params::openscap_url,
  $openscap_enabled             = $yumrepos::params::openscap_enabled,
  $openscap_gpgcheck            = $yumrepos::params::openscap_gpgcheck,
  $openscap_includepkgs         = $yumrepos::params::openscap_includepkgs,
  $openscap_exclude             = $yumrepos::params::openscap_exclude,
  $openscap_skip_if_unavailable = true,
  ) inherits yumrepos::params {
  
  file { "/etc/pki/rpm-gpg/RPM-GPG-KEY-openscap":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => "puppet:///modules/yumrepos/etc/pki/rpm-gpg/RPM-GPG-KEY-openscap",
  }

  yumrepo { 'openscap-latest':
    descr               => 'Openscap Latest',
    baseurl             => $openscap_url,
    enabled             => $openscap_enabled,
    gpgcheck            => $openscap_gpgcheck,
    includepkgs         => $openscap_includepkgs,
    exclude             => $openscap_exclude,
    skip_if_unavailable => $openscap_skip_if_unavailable,
    gpgkey              => "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-openscap",
    require             => File["/etc/pki/rpm-gpg/RPM-GPG-KEY-openscap"],
  }

  yumrepos::rpm_gpg_key { "openscap-latest": path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-openscap", }

}
