# Class: yumrepos::rsyslog
#
# Installs the latest Rsyslog V8 Stable Repo
#
class yumrepos::rsyslog (
  $rsyslog_url = $yumrepos::params::rsyslog_url,
  $rsyslog_enabled = $yumrepos::params::rsyslog_enabled,
  $rsyslog_gpgcheck = $yumrepos::params::rsyslog_gpgcheck,
  $rsyslog_includepkgs = $yumrepos::params::rsyslog_includepkgs,
  $rsyslog_exclude = $yumrepos::params::rsyslog_exclude,
) inherits yumrepos::params {

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-rsyslog':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/yumrepos/etc/pki/rpm-gpg/RPM-GPG-KEY-rsyslog',
  }

  yumrepo { 'rsyslog_v8':
    descr       => "Adiscon CentOS-${::operatingsystemmajrelease} - local packages for ${::architecture}",
    baseurl     => $rsyslog_url,
    enabled     => $rsyslog_enabled,
    includepkgs => $rsyslog_includepkgs,
    exclude     => $rsyslog_exclude,
    gpgcheck    => $rsyslog_gpgcheck,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-rsyslog',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-rsyslog'],
  }
  
  yumrepos::rpm_gpg_key { "rsyslog_v8":
      path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-rsyslog",
  }
}
