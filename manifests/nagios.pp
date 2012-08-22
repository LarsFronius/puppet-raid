class raid::nagios {
    case $::raid_bus_controller_0_device {
        /^LSI/: {
            class { 'raid::nagios::lsi': }
        }
        undef: {
            notify { 'No RAID Controller found!': }
        }
        default: {
            notify { "Unsupported RAID: ${::raid_bus_controller_0_device}": }
        }
    }
}
