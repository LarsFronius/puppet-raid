class raid::repo {
    case $::operatingsystem {
        'Debian': {
            class { 'raid::repo::debian':
                require => Anchor['raid::repo::alpha'],
                before  => Anchor['raid::repo::omega'],
            }
        }
        default: {
            notify { "Unsupported OS family: ${::operatingsystem}": }
        }
    }
}
