{
    "spec": {
        "boot": {
            "delay": 1,
            "efi_legacy_boot": false,
            "enter_setup_mode": true,
            "network_protocol": "IPV4",
            "retry": true,
            "retry_delay": 1,
            "type": "EFI"
        },
        "boot_devices": [
            {
                "type": "CDROM"
            },
            {
                "type": "CDROM"
            }
        ],
        "cdroms": [
            {
                "allow_guest_control": true,
                "backing": {
                    "device_access_type": "EMULATION",
                    "host_device": "string",
                    "iso_file": "string",
                    "type": "ISO_FILE"
                },
                "ide": {
                    "master": true,
                    "primary": true
                },
                "sata": {
                    "bus": 1,
                    "unit": 1
                },
                "start_connected": true,
                "type": "IDE"
            },
            {
                "allow_guest_control": true,
                "backing": {
                    "device_access_type": "EMULATION",
                    "host_device": "string",
                    "iso_file": "string",
                    "type": "ISO_FILE"
                },
                "ide": {
                    "master": true,
                    "primary": true
                },
                "sata": {
                    "bus": 1,
                    "unit": 1
                },
                "start_connected": true,
                "type": "IDE"
            }
        ],
        "cpu": {
            "cores_per_socket": 1,
            "count": 2,
            "hot_add_enabled": true,
            "hot_remove_enabled": true
        },
        "disks": [
            {
                "backing": {
                    "type": "VMDK_FILE",
                    "vmdk_file": "string"
                },
                "ide": {
                    "master": true,
                    "primary": true
                },
                "new_vmdk": {
                    "capacity": 1,
                    "name": "string"
                },
                "sata": {
                    "bus": 1,
                    "unit": 1
                },
                "scsi": {
                    "bus": 1,
                    "unit": 1
                },
                "type": "IDE"
            },
            {
                "backing": {
                    "type": "VMDK_FILE",
                    "vmdk_file": "string"
                },
                "ide": {
                    "master": true,
                    "primary": true
                },
                "new_vmdk": {
                    "capacity": 1,
                    "name": "string"
                },
                "sata": {
                    "bus": 1,
                    "unit": 1
                },
                "scsi": {
                    "bus": 1,
                    "unit": 1
                },
                "type": "IDE"
            }
        ],
        "guest_OS": "RHEL_7_64: Red Hat Enterprise Linux 7 (64-bit)",
        "hardware_version": "",
        "memory": {
            "hot_add_enabled": true,
            "size_MiB": 1
        },
        "name": "string",
        "nics": [
            {
                "allow_guest_control": true,
                "backing": {
                    "distributed_port": "string",
                    "network": "obj-103",
                    "type": "STANDARD_PORTGROUP"
                },
                "mac_address": "string",
                "mac_type": "MANUAL",
                "pci_slot_number": 1,
                "start_connected": true,
                "type": "VMXNET3",
                "upt_compatibility_enabled": true,
                "wake_on_lan_enabled": true
            },
            {
                "allow_guest_control": true,
                "backing": {
                    "distributed_port": "string",
                    "network": "obj-103",
                    "type": "STANDARD_PORTGROUP"
                },
                "mac_address": "string",
                "mac_type": "MANUAL",
                "pci_slot_number": 1,
                "start_connected": true,
                "type": "E1000",
                "upt_compatibility_enabled": true,
                "wake_on_lan_enabled": true
            }
        ],
        "parallel_ports": [
            {
                "allow_guest_control": true,
                "backing": {
                    "file": "string",
                    "host_device": "string",
                    "type": "FILE"
                },
                "start_connected": true
            },
            {
                "allow_guest_control": true,
                "backing": {
                    "file": "string",
                    "host_device": "string",
                    "type": "FILE"
                },
                "start_connected": true
            }
        ],
        "placement": {
            "cluster": "obj-103",
            "datastore": "obj-103",
            "folder": "obj-103",
            "host": "obj-103",
            "resource_pool": "obj-103"
        },
        "sata_adapters": [
            {
                "bus": 1,
                "pci_slot_number": 1,
                "type": "AHCI"
            },
            {
                "bus": 1,
                "pci_slot_number": 1,
                "type": "AHCI"
            }
        ],
        "scsi_adapters": [
            {
                "bus": 1,
                "pci_slot_number": 1,
                "sharing": "NONE",
                "type": "BUSLOGIC"
            },
            {
                "bus": 1,
                "pci_slot_number": 1,
                "sharing": "NONE",
                "type": "BUSLOGIC"
            }
        ],
        "serial_ports": [
            {
                "allow_guest_control": true,
                "backing": {
                    "file": "string",
                    "host_device": "string",
                    "network_location": "http://myurl.com",
                    "no_rx_loss": true,
                    "pipe": "string",
                    "proxy": "http://myurl.com",
                    "type": "FILE"
                },
                "start_connected": true,
                "yield_on_poll": true
            },
            {
                "allow_guest_control": true,
                "backing": {
                    "file": "string",
                    "host_device": "string",
                    "network_location": "http://myurl.com",
                    "no_rx_loss": true,
                    "pipe": "string",
                    "proxy": "http://myurl.com",
                    "type": "FILE"
                },
                "start_connected": true,
                "yield_on_poll": true
            }
        ]
    }
}