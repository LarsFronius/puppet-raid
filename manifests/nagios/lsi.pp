class raid::nagios::lsi {
    file { '/usr/sbin/check-raid':
        ensure => link,
        target => '/usr/sbin/megaclisas-status'
    }
}
