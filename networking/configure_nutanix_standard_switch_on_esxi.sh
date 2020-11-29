# Create Nutanix Switch on VMware
esxcli network vswitch standard add --vswitch-name=vSwitch0
esxcli network vswitch standard add --vswitch-name=vSwitchNutanix

# Create Port Groups Management Network and VM Network on vSwitch0
esxcli network vswitch standard portgroup add --portgroup-name="Management Network" --vswitch-name=vSwitch0
esxcli network vswitch standard portgroup add --portgroup-name="VM Network" --vswitch-name=vSwitch0

# Change the VLAN ID on a port group
esxcfg-vswitch -p "portgroup_name" -v VLAN_ID virtual_switch_name

# Create Port Groups vmk-svm-iscsi-pg and svm-iscsi-pg on vSwitchNutanix
esxcli network vswitch standard portgroup add --portgroup-name="vmk-svm-iscsi-pg" --vswitch-name=vSwitchNutanix
esxcli network vswitch standard portgroup add --portgroup-name="svm-iscsi-pg" --vswitch-name=vSwitchNutanix

# Create VMkernel Port vmk0 for vSwitch0 and assign to VMkerne Port Group Management Network
esxcli network ip interface add --interface-name=vmk0 --portgroup-name="Management Network"
esxcli network ip interface ipv4 set --interface-name=vmk0 --ipv4=<ESXi Host Mgmt IP address> --netmask=<subnet mask> --type=static

# Create VMkernel Port vmk1 for vSwitchNutanix and assign to VMkernel Port Group vmk-svm-iscsi-pg
esxcli network ip interface add --interface-name=vmk1 --portgroup-name="vmk-svm-iscsi-pg"
esxcli network ip interface ipv4 set --interface-name=vmk1 --ipv4=192.168.5.1 --netmask=255.255.255.0 --type=static

# Assign default gateway to ESXi
esxcli network ip route ipv4 add --gateway=<GATEWAY> --network=default

# Check vmknics are created
esxcfg-vmknic -l

# Assign two 10GbE uplinks to vSwitchNutanix
esxcli network vswitch standard uplink add --uplink-name=vmnic0 --vswitch-name=vSwitch0
esxcli network vswitch standard uplink add --uplink-name=vmnic1 --vswitch-name=vSwitch0