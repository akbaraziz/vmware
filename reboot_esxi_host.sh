# Reboot the ESXi host. The "-d" is a countdown timer in seconds. Maintenance mode must be enabled before running this command.
esxcli system shutdown reboot -d 10 -r “Patch Updates”