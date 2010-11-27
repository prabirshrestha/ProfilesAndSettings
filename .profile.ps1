###############################################################################
# powershell initialization script
# call from profile.ps1, like this:
#     . "$env:HOME\.profile.ps1"
# (notice the '.')
# make sure you set the HOME environent variable (ex:  c:\HOMEDIRl)
# 
###############################################################################

#
# Set the $HOME variable for our use
# and make powershell recognize ~\ as $HOME
# in paths
#
set-variable -name HOME -value (resolve-path $env:Home) -force
(get-psprovider FileSystem).Home = $HOME

function PrepareEnvironment(
	[string] $windowsUsername,
	[string] $computerName)
{
	Write-Host "Setting environment for '$windowsUserName@$computerName'" -foregroundcolor cyan
	$Host.UI.RawUI.WindowTitle = "$windowsUserName@$computerName"
}

$computerName = Get-Content Env:\COMPUTERNAME
$windowsUserName =  Get-Content Env:\USERNAME
switch(Get-Content Env:\COMPUTERNAME){
	"PSLAPTOP"{
		PrepareEnvironment $windowsUserName $computerName;
		break;
	}
	default{
		break;
	}
}