<#
.SYNOPSIS
  Powers off or migrates VMs to a different VMHost then applies a baseline and remediate the host.
.DESCRIPTION
  <Brief description of script>
.PARAMETER VIServer
    The name or IP address of your vCenter server appliance.
.PARAMETER VMHost
    The name or IP address of the VMHost you want to upgrade.
.PARAMETER Baseline
    The name of the baseline you want to attach to hosts.
.INPUTS
  None.
.OUTPUTS
  Log file stored in C:\Windows\Temp\<name>.log>
  Email will be sent once script completes.
.NOTES
  Version:        1.0
  Author:         Kirk Whetton.
  Creation Date:  13/03/2019.
  Purpose: To upgrade a vSphere host or hosts.
  
.EXAMPLE
  #This starts a host upgrade on the ContosoVIserver in the cluster Contoso_Cluster on the VMHost Contoso-ESXi01.
  New-VMHostUpgrade -VIServer "ContosoVIServer.Domain.com" -Cluster "Contoso_Cluster" -VMHost "Contoso-ESXi01.domain.com" -UserName "Domain\Username" 

  #This starts a host upgrade on the ContosoVIserver in the cluster Contoso_Cluster on the VMHost's contained in the text file "c:\temp\VMHostList.txt"
  New-VMHostUpgrade -VIServer "ContosoVIServer.Domain.com" -Cluster "Contoso_Cluster" -VMHostList "c:\temp\VMHostList.txt" -UserName "Domain\Username" 
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = "Stop"

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version = "1.0"

#Log File Info

$Logfile = "C:\temp\Start-VMHostUpgrade.log"
$Baseline = "Name of vCenter patch baseline."
$Subject = "vSphereHost upgrade status."
$SMTPServer = 'Your-SMTPServer.contoso.com'
$To = "Recipient.Email@contoso.com"
$From = 'vSphereAdmin@Contoso.com'
$Datastore = "datastore_naming_convention*"

#-----------------------------------------------------------[Functions]------------------------------------------------------------


Function Start-VMHostUpgrade {

    Param (

        [Parameter(Mandatory = $True)]
        [String]$VIServer,

        [Parameter(Mandatory = $True)]
        [String]$VMHost,
  
        [ValidateSet("Yes", "No")]
        [Parameter(Mandatory = $True)]
        [string]$PowerOffVMs,
  
        [Parameter(Mandatory = $True)]
        [String]$Username,

        [Parameter(Mandatory = $True)]
        [Security.SecureString]$Password

    ) #Params
  
    Begin {
        
        $Credential = New-Object System.Management.Automation.PSCredential ("$Username", $Password)
    
        Import-Module -Name VMware.VimAutomation.Core

        Import-Module -Name VMware.VumAutomation

        Connect-VIServer -Server $VIServer -Credential $Credential -Force | Out-Null
           
    } #Begin
  
    Process {

        $VMs = Get-VMHost -Name $VMHost | Get-VM | Where-Object { $_.PowerState -Like "PoweredOn" } | Sort-Object -Property Name
    
        foreach ($VM in $VMs) {
        
            If ($PowerOffVMs -like "Yes") {

                Write-Host "PowerOff VMs Enabled, shutting down $VM" -ForegroundColor Green

                Start-Sleep -Seconds 3

                Stop-VM -VM $VM -Confirm:$False -RunAsync | Out-Null

            }

            Else {

                $TargetVMHost = Get-Cluster -Name $Cluster | 
                Get-VMHost | 
                Where-Object { ($_.Name -Notlike $VMHost) } | 
                Sort-Object -Property MemoryUsageGB | 
                Select-Object -First 1

                $TargetDataStore = Get-VMHost -Name $TargetVMHost | Get-Datastore | Where-Object { ($_.Name -Like "$Datastore") }

                Write-Host "VM $VM is migrating to VMHost $TargetVMHost on the datastore $TargetDataStore" -ForegroundColor Green

                Start-Sleep -Seconds 2

                Move-VM -VM $VM.Name -Destination $TargetVMHost -Datastore $TargetDataStore -VMotionPriority Standard -DiskStorageFormat Thin -Verbose
          
            } #Else

        } #Foreach 

        Start-Sleep -Seconds 2

        $VMs2 = Get-VMHost -Name $VMHost | Get-VM | Where-Object { ($_.PowerState -Like "PoweredOn") } | Sort-Object -Property Name

        If (!$VMs2) {
      
            Write-Host "$VMHost is entering maintenance mode." -ForegroundColor Green
            Set-VMHost -VMHost $VMHost -State Maintenance | Out-Null

            $Baseline = Get-Baseline -Name $Baseline
        
            Write-Host "Attaching baseline "$($Baseline).name" to $VMHost." -ForegroundColor Green
            Attach-Baseline -Baseline $Baseline -Entity $VMHost | Out-Null

            Write-Host "Remediating host $VMHost." -ForegroundColor Green
            Remediate-Inventory -Baseline $Baseline -Entity $VMHost -Confirm:$false -ClusterDisableHighAvailability:$True | Out-Null
        
            Write-Host "Exiting maintenance mode." -ForegroundColor Green
            Set-VMHost -VMhost $VMHost -State Connected | Out-Null

            Write-Host "VMHost $($VMHost) was upgraded succesfully."
            $Message = "VMHost $($VMHost) was upgraded succesfully."

        } #If

        Else {
        
            Write-Host "VMs were still found on the host $($VMHost), aborting upgrade." -ForegroundColor Red
            $Message = "VMs were still found on the host $($VMHost), aborting upgrade."

        } #Else
    
        foreach ($VM in $VMs) {

            If ($PowerOffVMs -Like "Yes") {
        
                Write-Host "Starting VM $VM" -ForegroundColor Green

                Start-VM -VM $VM -Confirm:$False | Out-Null

            }

        }
      
    } #Process
  
    End {

        Send-MailMessage -To $To -From $From -Subject $Subject -SmtpServer $SMTPServer -Body $Message

    } #End

} #Function



#-----------------------------------------------------------[Execution]------------------------------------------------------------

Start-Transcript -Path $LogFile -Append

Start-VMHostUpgrade -VIServer "vcenterserver.contoso.com" -Username "vs.local\vSphereAdmin" -VMHost "ESXi01.contoso.com" -PowerOffVMs No 

Stop-Transcript
