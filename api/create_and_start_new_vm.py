#!/usr/bin/python
import vm_include


def main():

    # connection properties
    # change these to match your installation
host = "yourvspherehost"
host_user = "root"
host_pw = "vmware"

# properties of the new VM:
guest_name = "newvm"  # name of the VM
guest_mem = 1024  # memory in MB
guest_cpu = 1  # number of virtual CPU
guest_space = 2  # space in GB
datastore = "non-ssd"  # name of the datastore
esx_host = "10.0.0.1"  # specific host in the cluster
guest_dc = "testdc"  # datacenter name
guest_ver = "vmx-08"  # version of VMX (v8 is editable via the client)
guest_iso = ""  # iso to mount (from datastore)
guest_os = "rhel6Guest"  # guest-template
guest_network = "VM Network"  # network-name
guest_enterbios = False

# connect to the host
host_con = vm_include.connectToHost(host, host_user, host_pw)

# create the new VM
res = vm_include.createGuest(host_con, guest_dc, esx_host, guest_name, guest_ver, guest_mem,
                             guest_cpu, guest_iso, guest_os, guest_space, datastore, guest_network, guest_enterbios)
print "Result:", res

# start the new VM
vm_include.powerOnGuest(host_con, guest_name)

# disconnect from host
host_con.disconnect()

if __name__ == '__main__':
main()
