node default {
  file { '/home/vagrant/.hushlogin':
    owner   => 'vagrant',
    group   => 'vagrant',
    content => '',
  }
  package { 'language-pack-en': ensure => installed }
}
