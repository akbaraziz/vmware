Get-VM | Select -property Name, @{N=”Cluster”;E={Get-Cluster -VM $_}},@{N=’IP’;E={$_.guest.IPAddress[0]}} , “Guest”, Notes, NumCpu,CoresPerSocket, MemoryGB, ProvisionedSpaceGB , UsedSpaceGB
Get-VM | Select -property Name, @{N=”Cluster”;E={Get-Cluster -VM $_}},@{N=’IP’;E={$_.guest.IPAddress[0]}} , “Guest”

#foreach($vm in Get-VM){
# $vm.Guest.IPAddress[0] |
# Select -property Name, @{N=”Cluster”;E={Get-Cluster -VM $_}}, @{N=’IP’;E={$_.guest.IPAddress[0]}} , “Guest”, ProvisionedSpaceGB , UsedSpaceGB, Notes, NumCpu, CoresPerSocket, MemoryGB
#}
#foreach($vm in Get-VM){
# $vm.Guest.IPAddress[0] |
# Select @{N=’Name’;E={$vm.name}},@{N=’IP’;E={$_}}, @{N=”Cluster”;E={Get-Cluster -VM $_}}, @{N=”Operating System”;E={Guest}}, @{N=”Notes”;E={Notes}}, @{N=”CPU Count”;E={NumCpu}}, @{N=”Core Count”;E={CoresPerSocket}}, @{N=”RAM”;E={MemoryGB}}, @{N=”Provisioned Capacity”;E={ProvisionedSpaceGB}}, @{N=”Used Space”;E={UsedSpaceGB}}
#}

# ProvisionedSpaceGB , UsedSpaceGB, Notes, NumCpu, CoresPerSocket, MemoryGB
#, UsedSpaceGB
#Guest
#Notes
#NumCpu
#CoresPerSocket

#MemoryGB