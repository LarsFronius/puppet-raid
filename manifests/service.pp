class raid::service (
    $service      = $raid::params::service,
    $raid_service = $::raid_service,
    $raid_mailto  = $::raid_mailto,
    $raid_period  =  $::raid_period,
    $raid_remind  = $::raid_remind
    ) inherits raid::params {

    case $raid_service {
      /^(running|true)$/,undef,default: {
          $raid_service_ensure = 'running'
          $raid_service_enable = true
      }
      /^(stopped|false)$/: {
          $raid_service_ensure = 'stopped'
          $raid_service_enable = false
      }
    }

    service { $service:
        ensure => $raid_service_ensure,
        enable => $raid_service_enable
    }

    file { "/etc/default/${service}":
      ensure => present
    }

    if $raid_mailto {
        augeas { 'set_default_mailto':
          context => "/files/etc/default/${service}",
          changes => "set MAILTO ${raid_mailto}",
          require => File["/etc/default/${service}"]
        }
    }

    if $raid_period {
        augeas { 'set_default_period':
          context => "/files/etc/default/${service}",
          changes => "set PERIOD ${raid_period}",
          require => File["/etc/default/${service}"]
        }
    }

    if $raid_remind {
        augeas { 'set_default_remind':
          context => "/files/etc/default/${service}",
          changes => "set REMIND ${raid_remind}",
          require => File["/etc/default/${service}"]
        }
    }
}
