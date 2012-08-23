class raid::nagios (
    $nagioscheck = $raid::params::nagioscheck
    ) inherits raid::params
{
    file { '/usr/sbin/check-raid':
        ensure => link,
        target => $nagioscheck
    }

    @@nagios_command { 'check_raid':
        command_line => '/usr/sbin/check-raid --nagios',
        require      => File['/usr/sbin/check-raid']
    }
}
