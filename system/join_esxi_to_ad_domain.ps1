Get-VMHostAuthentication -VMHost <VMHost> | Set-VMHostAuthentication -JoinDomain -Domain <Domain> -User <Username> -Password <Password>

. For all hosts
Get-VMHostAuthentication -VMHost * | Set-VMHostAuthentication -JoinDomain -Domain “homelab.local” -User “user01@homelab.local”  -Password <Password>