class raid::params {
  if !$controller_0_vendor and $::raid_bus_controller_0_vendor {
    $controller_0_vendor = $::raid_bus_controller_0_vendor
    $controller_0_device = $::raid_bus_controller_0_device
  }

  if !$controller_0_vendor and $::serial_attached_scsi_controller_0_vendor {
    $controller_0_vendor = $::serial_attached_scsi_controller_0_vendor
    $controller_0_device = $::serial_attached_scsi_controller_0_device
  }

  case $controller_0_vendor {
    /^LSI/: {
      case $controller_0_device {
        'LSI MegaSAS 9260': {
          $packages = [ 'megaclisas-status', 'megacli' ]
          $nagioscheck = [ '/usr/sbin/megaclisas-status' ]
          $service = 'megaclisas-statusd'
        }
        'SAS2008 PCI-Express Fusion-MPT SAS-2 [Falcon]': {
          $packages = [ 'sas2ircu-status', 'sas2ircu' ]
          $nagioscheck = [ '/usr/sbin/sas2ircu-status' ]
          $service = 'sas2ircu-statusd'
        }
        default: {
          notify {
            "Unsupported RAID Device: ${controller_0_device}":
          }
        }
      }
    }
    default: {
      notify { "Unsupported RAID Vendor: ${controller_0_vendor}": }
    }
    undef: {
      notify { 'No RAID Controller found': }
    }
  }
}
