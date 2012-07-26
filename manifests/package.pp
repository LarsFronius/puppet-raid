class raid::package {
    case $::raid_bus_controller_0_device {
        /^LSI/: {
            class { 'raid::package::lsi': }
        }
        undef: {
            notify { "No RAID Controller found": }
        }
        default: {
            notify { "Unsupported RAID Controller: ${::raid_bus_controller_0_device}": }
        }
    }
}
