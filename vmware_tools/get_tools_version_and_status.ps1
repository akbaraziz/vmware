get-vm | select -property @{N=”Name”; E={$_.name}}, ToolsVersion,ToolsVersionStatus