class raid::nagios (
    $nagioscheck = $raid::params::nagioscheck
    ) inherits raid::params
{
    file { '/usr/sbin/check-raid':
        ensure => link,
        target => $nagioscheck
    }
}
