# Class: yumrepos::puppetlabs
#
# Installs the latest Puppet Labs (currently Puppet 4 PC1)
#
class yumrepos::puppetlabs_latest (
  $puppetlabs_latest_url = $yumrepos::params::puppetlabs_latest_url,
  $puppetlabs_latest_enabled = $yumrepos::params::puppetlabs_latest_enabled,
  $puppetlabs_latest_gpgcheck = $yumrepos::params::puppetlabs_latest_gpgcheck,
  $puppetlabs_latest_includepkgs = $yumrepos::params::puppetlabs_latest_includepkgs,
  $puppetlabs_latest_exclude = $yumrepos::params::puppetlabs_latest_exclude,
) inherits yumrepos::params {

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs':
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => 'puppet:///modules/yumrepos/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
  }

  yumrepo { 'puppetlabs-pc1':
    descr       => 'Puppet Labs PC1',
    baseurl     => $puppetlabs_latest_url,
    enabled     => $puppetlabs_latest_enabled,
    includepkgs => $puppetlabs_latest_includepkgs,
    exclude     => $puppetlabs_latest_exclude,
    gpgcheck    => $puppetlabs_latest_gpgcheck,
    gpgkey      => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs',
    require     => File['/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs'],
  }
  yumrepos::rpm_gpg_key { "puppetlabs-pc1":
      path => "/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetlabs",
  }
}
