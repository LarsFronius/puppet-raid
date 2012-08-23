class raid::repo {
    anchor { 'raid::repo::start': }
    anchor { 'raid::repo::end': }

    case $::operatingsystem {
        'Debian': {
            class { 'raid::repo::debian':
                require => Anchor['raid::repo::start'],
                before  => Anchor['raid::repo::end']
            }
        }
        default: {
            notify { "Unsupported OS family: ${::operatingsystem}": }
        }
    }
}
