#----------------------------------------------------------------------------------------------
#Step 1- Authenticate with the Server
#Ignore Server Certs- This is on my not-very-well-certified home lab.
if (-not ([System.Management.Automation.PSTypeName]'ServerCertificateValidationCallback').Type)
{
$certCallback=@"
using System;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
public class ServerCertificateValidationCallback
{
public static void Ignore()
{
if(ServicePointManager.ServerCertificateValidationCallback ==null)
{
ServicePointManager.ServerCertificateValidationCallback +=
delegate
(
Object obj,
X509Certificate certificate,
X509Chain chain,
SslPolicyErrors errors
)
{
return true;
};
}
}
}
"@
Add-Type $certCallback
}
[ServerCertificateValidationCallback]::Ignore();

#Get Some Credentials and Determine Authorisation Methods
$Credential = Get-Credential
$auth = [System.Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($Credential.UserName+':'+$Credential.GetNetworkCredential().Password))
$head = @{
'Authorization' = "Basic $auth"
}

#Authenticate against vCenter
$r = Invoke-WebRequest -Uri https://10.10.10.50/rest/com/vmware/cis/session -Method Post -Headers $head
$token = (ConvertFrom-Json $r.Content).value
$session = @{'vmware-api-session-id' = $token}