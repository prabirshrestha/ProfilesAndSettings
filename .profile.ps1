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

#
# global variables and core env variables 
#
$TOOLS = [Environment]::GetFolderPath("MyDocuments") + "\PortableApps"

#
#  good place change  HOME/OFFICE configurations out here
#
$computerName = Get-Content Env:\COMPUTERNAME
$windowsUserName =  Get-Content Env:\USERNAME
switch(Get-Content Env:\COMPUTERNAME){
	"PSLAPTOP"{
		break;
	}
	default{
		break;
	}
}

#
# Updated the powershell window title with username@computername
#
Write-Host "Setting environment for '$windowsUserName@$computerName'" -foregroundcolor cyan
$Host.UI.RawUI.WindowTitle = "$windowsUserName@$computerName"

#
# set path to include my usual directories
# and configure dev environment
#
function script:append-path { 
   if ( -not $env:PATH.contains($args) ) {
      $env:PATH += ';' + $args
   }
}

#
# add the portable applications to path
#
Set-Alias ajaxmin 	"$TOOLS\ajaxmin\ajaxmin.exe"
Set-Alias filezilla "$TOOLS\Filezilla\filezilla.exe"
Set-Alias kdiff3	"$TOOLS\kdiff3\kdiff3.exe"
Set-Alias moma 		"$TOOLS\MoMA\MoMA.exe" # Mono Migration Analyzer
Set-Alias notepad++ "$TOOLS\Notepad++\notepad++.exe"
Set-Alias np notepad++
Set-Alias photoshop "$TOOLS\Photoshop\Photoshop.exe"
Set-Alias reflector "$TOOLS\Reflector\reflector.exe"
Set-Alias pik "$TOOLS\pik\pik.bat" # set aliaas for pik


# uuidgen.exe replacement
function uuidgen {
   [guid]::NewGuid().ToString('d')
}