class raid::repo {
    case $::operatingsystem {
        'Debian': {
            include 'raid::repo::debian'
        }
        default: {
            notify { "Unsupported OS family: ${::operatingsystem}": }
        }
    }
}
