# Class: raid
#
# This module manages raid
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
# [Remember: No empty lines between comments and class definition]
class raid (
    $packages = $raid::params::packages,
    $service = $raid::params::service,
    $nagioscheck = $raid::params::nagioscheck
    ) inherits raid::params
{

    if $packages {
      class {'raid::package':
        require => Class['raid::repo'],
        notify  => Anchor['raid::end']
      }
    }

    if $service {
      class {'raid::service':
        require => Class['raid::package'],
        notify  => Anchor['raid::end']
      }
    }

    if $nagioscheck {
      class {'raid::nagios':
        require => Class['raid::package'],
        notify  => Anchor['raid::end']
      }
    }

    anchor {'raid::start': }~>
    class {'raid::repo': }~>
    anchor {'raid::end': }

}
