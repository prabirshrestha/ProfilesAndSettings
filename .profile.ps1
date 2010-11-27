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
append-path "$TOOLS"
append-path "$TOOLS\ajaxmin"
append-path "$TOOLS\Filezilla"
append-path "$TOOLS\kdiff3"
append-path "$TOOLS\MoMA" # Mono Migration Analyzer
append-path "$TOOLS\Notepad++"
append-path "$TOOLS\Photoshop"
append-path "$TOOLS\Reflector"
set-alias np notepad++


# uuidgen.exe replacement
function uuidgen {
   [guid]::NewGuid().ToString('d')
}