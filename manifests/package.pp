class raid::package {
    case $::raid_bus_controller_0_device {
        /^LSI/: {
            class { 'raid::package::lsi': }
        }
        default: {
            fail( "Unsupported RAID Controller: ${::raid_bus_controller_0_device}" )
        }
    }
}
