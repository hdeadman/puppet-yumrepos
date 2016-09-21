# Class: yumrepos::ppas95
#
# Installs the PPAS95 yum repository.
#
class yumrepos::ppas95 (
  $ppas95_username = $yumrepos::params::ppas95_username,
  $ppas95_password = $yumrepos::params::ppas95_password,
  $ppas95_url_prefix = $yumrepos::params::ppas95_url_prefix,
  $ppas95_url_suffix = $yumrepos::params::ppas95_url_suffix,
  $ppas_tools_url_suffix = $yumrepos::params::ppas_tools_url_suffix,
  $ppas95_enabled = $yumrepos::params::ppas95_enabled,
  $ppas95_gpgcheck = $yumrepos::params::ppas95_gpgcheck,
  $ppas95_includepkgs = $yumrepos::params::ppas95_includepkgs,
  $ppas95_exclude = $yumrepos::params::ppas95_exclude,
  $ppas_tools_includepkgs = $yumrepos::params::ppas_tools_includepkgs,
  $ppas_tools_exclude = $yumrepos::params::ppas_tools_exclude,
) inherits yumrepos::params {

  file { "/etc/pki/rpm-gpg/ENTERPRISEDB-GPG-KEY":
    ensure => present,
    owner  => root,
    group  => root,
    mode   => '0644',
    source => "puppet:///modules/yumrepos/etc/pki/rpm-gpg/ENTERPRISEDB-GPG-KEY",
  }

  $ppas95_url = "${ppas95_url_prefix}${ppas95_username}:${ppas95_password}@${ppas95_url_suffix}"
  $ppas_tools_url = "${ppas95_url_prefix}${ppas95_username}:${ppas95_password}@${ppas_tools_url_suffix}"

  yumrepo { 'ppas95':
    descr       => 'Postgres Plus Advanced Server 9.5 $releasever - $basearch',
    baseurl     => $ppas95_url,
    enabled     => $ppas95_enabled,
    gpgcheck    => $ppas95_gpgcheck,
    includepkgs => $ppas95_includepkgs,
    exclude     => $ppas95_exclude,
    gpgkey      => "file:///etc/pki/rpm-gpg/ENTERPRISEDB-GPG-KEY",
    require     => File["/etc/pki/rpm-gpg/ENTERPRISEDB-GPG-KEY"],
  }

  yumrepo { 'enterprisedb-tools':
    descr       => 'EnterpriseDB Tools $releasever - $basearch',
    baseurl     => $ppas_tools_url,
    enabled     => $ppas95_enabled,
    gpgcheck    => $ppas95_gpgcheck,
    includepkgs => $ppas_tools_includepkgs,
    exclude     => $ppas_tools_exclude,
    gpgkey      => "file:///etc/pki/rpm-gpg/ENTERPRISEDB-GPG-KEY",
    require     => File["/etc/pki/rpm-gpg/ENTERPRISEDB-GPG-KEY"],
  }

  yumrepos::rpm_gpg_key { "ppas95 ENTERPRISEDB-GPG-KEY":
      path => "/etc/pki/rpm-gpg/ENTERPRISEDB-GPG-KEY",
  }

}


#[enterprisedb-tools]
#name=EnterpriseDB Tools $releasever - $basearch
#baseurl=http://davison_joseph:Passw0rd!@yum.enterprisedb.com/tools/redhat/rhel-$releasever-$basearch
#enabled=1
#gpgcheck=1
#gpgkey=file:///etc/pki/rpm-gpg/ENTERPRISEDB-GPG-KEY 