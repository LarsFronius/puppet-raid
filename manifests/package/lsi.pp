class raid::package::lsi {
    case $::raid_bus_controller_0_device {
        /^LSI MegaSAS/: {
            package { 'megacli': }
            package { 'megaclisas-status': }
        }
        default: {
            notify { "Could not find package for ${::raid_bus_controller_0_device}" : }
        }
        undef: {
            notify { "Could not find any RAID device" : }
        }
    }
}
