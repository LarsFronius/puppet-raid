class raid::params {
    case $::raid_bus_controller_0_vendor {
        /^LSI/: {
            case $::raid_bus_controller_0_device {
                /^LSI MegaSAS 9260$/: {
                    $packages = [ 'megaclisas-status', 'megacli' ]
                    $nagioscheck = [ '/usr/sbin/megaclisas-status' ]
                    $service = 'megaclisas-statusd'
                }
            }
        }
        undef: {
            notify { 'No RAID Controller found': }
        }
        default: {
            notify { "Unsupported RAID: ${::raid_bus_controller_0_device}": }
        }
    }
}
