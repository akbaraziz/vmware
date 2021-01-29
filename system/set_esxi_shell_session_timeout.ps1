#List UserVars.ESXiShellInteractiveTimeOut for each host
Get-VMHost | Select Name,
@{N = ”UserVars.ESXiShellInteractiveTimeOut”; E = { $_
        | Get-AdvancedSetting -Name
        UserVars.ESXiShellInteractiveTimeOut
        | Select -ExpandProperty Value }
}

# Set UserVars.ESXiShellTimeOut to 900 on all hosts
Get-VMHost
| Foreach { Get-AdvancedSetting -Entity $_ -Name
    UserVars.ESXiShellInteractiveTimeOut | Set-AdvancedSetting
    -Value 900 }