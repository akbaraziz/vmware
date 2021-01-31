#! /bin/bash

#
# Global Variables with default values.
#

UTILS_PATH="$(dirname "$(readlink -f "$0")")"
DS="datastore1"
VMDK_SIZE="50GB"
REMOTE_PORT="5000"
BIOS="false"
VM_DIR=""
HELP="false"
ISO_PATH=""
VMX_PATH=""
GUEST_OS="ubuntu-64"
REGISTER="true"
DISKTYPE="nvme"
TEMPLATE="$UTILS_PATH/templatevm/templatevm.vmx"
LIST_GUESTS="false"
CMD=`basename $0`

# Guest OS arrays start.

GUEST_KEYS=( windows9 \
windows9-64 \
windows8 \
windows8-64 \
windows7 \
windows7-64 \
winvista \
winvista-64 \
winXPHome \
winXPPro \
winXPPro-64 \
win2000Pro \
winNT \
windows9srv-64 \
windows8srv-64 \
winHyperV \
windows7srv-64 \
longhorn \
longhorn-64 \
winNetStandard \
winNetStandard-64 \
winNetEnterprise \
winNetEnterprise-64 \
winNetBusiness \
winNetWeb \
winNetDatacenter \
winNetDatacenter-64 \
win2000Serv \
win2000AdvServ \
winMe \
win98 \
win95 \
win31 \
darwin16-64 \
darwin15-64 \
darwin14-64 \
darwin13-64 \
darwin12-64 \
darwin11-64 \
darwin11 \
darwin10-64 \
darwin10 \
darwin-64 \
darwin \
asianux7-64 \
asianux4 \
asianux4-64 \
asianux3 \
asianux3-64 \
centos \
centos-64 \
debian10 \
debian10-64 \
debian9 \
debian9-64 \
debian8 \
debian8-64 \
debian7 \
debian7-64 \
debian6 \
debian6-64 \
debian5 \
debian5-64 \
debian4 \
debian4-64 \
fedora \
fedora-64 \
mandrake \
mandriva \
mandriva-64 \
nld9 \
opensuse \
opensuse-64 \
oraclelinux \
oraclelinux-64 \
rhel7 \
rhel7-64 \
rhel6 \
rhel6-64 \
rhel5 \
rhel5-64 \
rhel4 \
rhel4-64 \
rhel3 \
rhel3-64 \
rhel2 \
redhat \
sjds \
sles12 \
sles12-64 \
sles11 \
sles11-64 \
sles10 \
sles10-64 \
sles \
sles-64 \
suse \
suse-64 \
turbolinux \
turbolinux-64 \
ubuntu \
ubuntu-64 \
vmware-photon-64 \
other3xlinux \
other3xlinux-64 \
other26xlinux \
other26xlinux-64 \
other24xlinux \
other24xlinux-64 \
otherlinux \
genericLinux \
otherlinux-64 \
solaris11-64 \
solaris10 \
solaris10-64 \
solaris9 \
solaris8 \
solaris7 \
solaris6 \
vmkernel65 \
vmkernel6 \
vmkernel5 \
vmkernel \
eComStation2 \
eComStation \
freeBSD \
freeBSD-64 \
dos \
os2 \
other \
other-64 \
openserver6 \
openserver5 )

GUEST_DESC=( "Windows 10" \
"Windows 10 x64" \
"Windows 8.x" \
"Windows 8.x x64" \
"Windows 7" \
"Windows 7 x64" \
"Windows Vista" \
"Windows Vista x64 Edition" \
"Windows XP Home Edition" \
"Windows XP Professional" \
"Windows XP Professional x64 Edition" \
"Windows 2000 Professional" \
"Windows NT" \
"Windows Server 2016" \
"Windows Server 2012" \
"Hyper-V (unsupported)" \
"Windows Server 2008 R2 x64" \
"Windows Server 2008" \
"Windows Server 2008 x64" \
"Windows Server 2003 Standard Edition" \
"Windows Server 2003 Standard x64 Edition" \
"Windows Server 2003 Enterprise Edition" \
"Windows Server 2003 Enterprise x64 Edition" \
"Windows Server 2003 Small Business" \
"Windows Server 2003 Web Edition" \
"Windows Server 2003 Datacenter Edition" \
"Windows Server 2003 Datacenter x64 Edition" \
"Windows 2000 Server" \
"Windows 2000 Advanced Server" \
"Windows Me" \
"Windows 98" \
"Windows 95" \
"Windows 3.1" \
"OS X 10.12" \
"OS X 10.11" \
"OS X 10.10" \
"OS X 10.9" \
"OS X 10.8" \
"Mac OS X 10.7" \
"Mac OS X 10.7 32-bit" \
"Mac OS X Server 10.6" \
"Mac OS X Server 10.6 32-bit" \
"Mac OS X Server 10.5" \
"Mac OS X Server 10.5 32-bit" \
"Asianux 7 64-bit" \
"Asianux 4" \
"Asianux 4 64-bit" \
"Asianux Server 3" \
"Asianux Server 3 64-bit" \
"CentOS" \
"CentOS 64-bit" \
"Debian 10.x" \
"Debian 10.x 64-bit" \
"Debian 9.x" \
"Debian 9.x 64-bit" \
"Debian 8.x" \
"Debian 8.x 64-bit" \
"Debian 7.x" \
"Debian 7.x 64-bit" \
"Debian 6" \
"Debian 6 64-bit" \
"Debian 5" \
"Debian 5 64-bit" \
"Debian 4" \
"Debian 4 64-bit" \
"Fedora" \
"Fedora 64-bit" \
"Mandrake Linux" \
"Mandriva Linux" \
"Mandriva Linux 64-bit" \
"Novell Linux Desktop 9" \
"OpenSUSE" \
"OpenSUSE 64-bit" \
"Oracle Linux" \
"Oracle Linux 64-bit" \
"Red Hat Enterprise Linux 7" \
"Red Hat Enterprise Linux 7 64-bit" \
"Red Hat Enterprise Linux 6" \
"Red Hat Enterprise Linux 6 64-bit" \
"Red Hat Enterprise Linux 5" \
"Red Hat Enterprise Linux 5 64-bit" \
"Red Hat Enterprise Linux 4" \
"Red Hat Enterprise Linux 4 64-bit" \
"Red Hat Enterprise Linux 3" \
"Red Hat Enterprise Linux 3 64-bit" \
"Red Hat Enterprise Linux 2" \
"Red Hat Linux" \
"Sun Java Desktop System" \
"SUSE Linux Enterprise 12" \
"SUSE Linux Enterprise 12 64-bit" \
"SUSE Linux Enterprise 11" \
"SUSE Linux Enterprise 11 64-bit" \
"SUSE Linux Enterprise 10" \
"SUSE Linux Enterprise 10 64-bit" \
"SUSE Linux Enterprise 7/8/9" \
"SUSE Linux Enterprise 7/8/9 64-bit" \
"SUSE Linux" \
"SUSE Linux 64-bit" \
"Turbolinux" \
"Turbolinux 64-bit" \
"Ubuntu" \
"Ubuntu 64-bit" \
"VMware Photon OS 64-bit" \
"Other Linux 3.x or later kernel" \
"Other Linux 3.x or later kernel 64-bit" \
"Other Linux 2.6.x kernel" \
"Other Linux 2.6.x kernel 64-bit" \
"Other Linux 2.4.x kernel" \
"Other Linux 2.4.x kernel 64-bit" \
"Other Linux 2.2.x kernel" \
"Other Linux" \
"Other Linux 64-bit" \
"Solaris 11 64-bit" \
"Solaris 10" \
"Solaris 10 64-bit" \
"Solaris 9 (unsupported)" \
"Solaris 8 (unsupported)" \
"Solaris 7" \
"Solaris 6" \
"VMware ESXi 6.5 or later" \
"VMware ESXi 6" \
"VMware ESXi 5.x" \
"VMware ESX/ESXi 4.x" \
"eComStation2" \
"eComStation" \
"FreeBSD" \
"FreeBSD 64-bit" \
"MS-DOS" \
"OS2" \
"Other" \
"Other 64-bit" \
"SCO OpenServer 6" \
"SCO OpenServer 5" )

# Guest OS arrays end.

ValidateGuest()
{
  n=${#GUEST_KEYS[*]}
  for (( i=0; i<=$(( n - 1 )); i++ ))
  do
   if [ "$GUEST_OS" == "${GUEST_KEYS[$i]}" ]; then
      return
   fi
  done

  ErrorOut "I don't recognize Guest OS \"$GUEST_OS\". Run \"$CMD -l\" to list out valid guest OSes."
}


PrintValidGuests()
{
   echo ""
   echo "The list of valid guest OSes."
   echo "Key      =     Description"
   echo "=========================="
   echo ""
   n=${#GUEST_KEYS[*]}
   for (( i=0; i<=$(( n - 1 )); i++ ))
   do
    echo "${GUEST_KEYS[$i]} = ${GUEST_DESC[$i]}"
   done
   echo "=========================="
   echo "Use the key to specify for guest OS when creating the VM."
}


#
# Usage
#
Usage()
{
   echo "
   This script uses a template .vmx file (not an OVF-template) and can create and
   register a HW version 13 VM with given name, guest OS, one THIN VMDK of given
   size sitting on [sata|scsi|nvme]0:0 node in the VM, with an ISO image connected
   to the VM at sata1:0, with either BIOS or EFI firmware, on a given datastore.


   Usage: $CMD [options]
   options: -v | --vm-name	      # VM name.
	    -d | --datastore	      # datastore name for the VM. Default is datastore2.
	    -t | --disktype	      # Type of the disk - scsi/sata/nvme. Default is nvme.
	    -b | --bios 	      # Create bios VM. Default is EFI VM.
	    -s | --size		      # VMDK size. Default is 50GB.
	    -i | --iso-path	      # Absolute ISO path.
	    -r | --remote-console     # Remote console vnc port number. Default is 5000.
            -g | --guest-os           # guestOS type. Default is ubuntu-64
            -n | --dont-register-vm   # Don't register the VM with hostd. Default behavior is to register.
            -l | --list-guests        # Print out a list of keys and descriptions of the valid guest OSes and exit.
            -h | --help               # This prints this help and exit.
   "
}


PrepareVMXFile()
{
   echo "Preparing VM with name $VM_DIR at $VMX_PATH..."
   mkdir "/vmfs/volumes/$DS/$VM_DIR"

   while read -r line
   do
      line=`echo $line | sed "s/templatevm/$VM_DIR/g"`
      echo $line >> $VMX_PATH
   done < $TEMPLATE
}

ErrorOut()
{
   echo "ERROR::  $1"
   exit 1
}

CreateAndAddVMDK()
{
   echo "Setting up $DISKTYPE ..."
   echo "Creating VMDK of size $VMDK_SIZE..."
   vmkfstools -c $VMDK_SIZE -d thin /vmfs/volumes/$DS/$VM_DIR/$VM_DIR.vmdk
   echo "Adding one $DISKTYPE disk ..."
   if [ "$DISKTYPE" = "scsi" ]; then
      echo "scsi0.virtualDev=\"lsisas1068\"" >> $VMX_PATH
   fi
   echo "$DISKTYPE""0.present=\"true\"" >> $VMX_PATH
   echo "$DISKTYPE""0:0.present=\"true\"" >> $VMX_PATH
   echo "$DISKTYPE""0:0.deviceType=\"disk\"" >> $VMX_PATH
   echo "$DISKTYPE""0:0.fileName=$VM_DIR.vmdk" >> $VMX_PATH
}

AddCDROM()
{
   echo "Setting up SATA CDROM..."
   echo "sata1.present=\"true\"" >> $VMX_PATH
   echo "sata1:0.present=\"true\"" >> $VMX_PATH
   echo "sata1:0.deviceType=\"cdrom-image\"" >> $VMX_PATH
   echo "sata1:0.startConnected=\"true\"" >> $VMX_PATH
   echo "sata1:0.fileName=\"$ISO_PATH\"" >> $VMX_PATH
}

AddRemote()
{
   echo "Setting up remote display port to $REMOTE_PORT..."
   echo "RemoteDisplay.vnc.enabled=\"true\"" >> $VMX_PATH
   echo "RemoteDisplay.vnc.port=$REMOTE_PORT" >> $VMX_PATH
}

SetupEFI()
{
   if [ "$BIOS" = "false" ]; then
      echo "Setting up firmware to EFI..."
      echo "firmware=\"efi\"" >> $VMX_PATH
   fi
}

SetupGOS()
{
   echo "Setting up guestOS type to $GUEST_OS..."
   echo "guestOS=\"$GUEST_OS\"" >> $VMX_PATH
}

RegisterVM()
{
   if [ "$REGISTER" = "true" ]; then
      echo "Register the VM with hostd..."
      vim-cmd solo/registervm $VMX_PATH
      echo "Please note the VMID from above to power it on."
   fi
}

#
# Create the VM from the template.
#
CreateVM()
{
   VMX_PATH="/vmfs/volumes/$DS/$VM_DIR/$VM_DIR.vmx"
   PrepareVMXFile
   CreateAndAddVMDK
   AddCDROM
   AddRemote
   SetupEFI
   SetupGOS
   RegisterVM
}

#
# Handle the bad args or help arg.
#
HandleArgs()
{
   if [ "$HELP" = "true" ]; then
      Usage
      exit 0
   fi

   if [ "$LIST_GUESTS" = "true" ]; then
     PrintValidGuests
     exit 0
   fi

   if [ "$ISO_PATH" = "" ]; then
      ErrorOut "ISO path not specified."
   fi

   if [ ! -e "$ISO_PATH" ]; then
      ErrorOut "Iso path: $ISO_PATH doesn't exist"
   fi

   path="/vmfs/volumes/$DS"
   if [ ! -e $path ]; then
     ErrorOut "Datastore: $DS doesn't exist."
   fi

   if [ "$VM_DIR" = "" ]; then
     ErrorOut "No VM name given."
   fi

   path="/vmfs/volumes/$DS/$VM_DIR"
   if [ -e $path ]; then
     ErrorOut "VM dir $path already exists."
   fi
   if [ "$DISKTYPE" != "scsi" ]; then
     if [ "$DISKTYPE" != "sata" ]; then
        if [ "$DISKTYPE" != "nvme" ]; then
          ErrorOut "Bad disktype $DISKTYPE."
        fi
     fi
   fi
   ValidateGuest
}


#
# Main function.
#
if [ $# -eq 0 ]; then
  Usage
  exit 0
fi

while [ $# -gt 0 ]; do
   case "$1" in
   (-v|--vm-name)
      shift
      VM_DIR=$1
      shift;;
   (-b|--bios)
      BIOS="true"
      shift;;
   (-d|--datastore)
      shift
      DS=$1
      shift;;
   (-s|--size)
      shift
      VMDK_SIZE=$1
      shift;;
   (-i|--iso-path)
      shift
      ISO_PATH=$1
      shift;;
   (-r|--remote-console)
      shift
      REMOTE_PORT=$1
      shift;;
   (-g|--guest-os)
      shift
      GUEST_OS=$1
      shift;;
   (-t|--disktype)
      shift
      DISKTYPE=$1
      shift;;
   (-h|--help)
     HELP="true"
     shift;;
   (-l|--list-guests)
     LIST_GUESTS="true"
     shift;;
   (*)
      echo "Unknown argument \"$1\"."
      exit 0
   esac
done

HandleArgs
CreateVM
