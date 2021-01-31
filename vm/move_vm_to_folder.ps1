Connect-VIServer -Server "vcenter-server-name.@@{DOMAIN_NAME}@@" -Protocol https -User "@@{VMWARE_ADMIN.username}@@" -Password "@@{VMWARE_ADMIN.secret}@@"

$Folder = Get-Folder -Name "FolderName"

Get-VM -Name @@{VM_NAME }@@ | Move-VM -Destination $Folder
