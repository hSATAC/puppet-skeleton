class common {
  class { 'vim':
    set_as_default => true,
  }
  package { 'git':
    ensure => installed,
  }
}
