###############################################################################
# powershell initialization script
# call from profile.ps1, like this:
#     . "$env:HOME\.profile.ps1"
# (notice the '.')
# make sure you set the HOME environent variable (ex:  c:\HOMEDIR)
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

Write-Host "Setting environment for '$windowsUserName@$computerName'" -foregroundcolor cyan

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
Set-Alias hg2git "$HOME\ps-scripts\hg2git.bat"
Set-Alias ajaxmin 	"$TOOLS\ajaxmin\ajaxmin.exe"
Set-Alias filezilla "$TOOLS\Filezilla\filezilla.exe"
Set-Alias moma 		"$TOOLS\MoMA\MoMA.exe" # Mono Migration Analyzer
Set-Alias notepad++ "$TOOLS\Notepad++\notepad++.exe"
Set-Alias np notepad++
Set-Alias photoshop "$TOOLS\Photoshop\Photoshop.exe"
Set-Alias reflector "$TOOLS\Reflector\reflector.exe"
Set-Alias pik "$TOOLS\pik\pik.bat"
Set-Alias touch "$TOOLS\git\bin\touch.exe"
Set-Alias ssh-keygen "$TOOLS\git\bin\ssh-keygen.exe"
Set-Alias wget "$TOOLS\gnu\wget\bin\wget.exe" # http://gnuwin32.sourceforge.net/packages/wget.htm (requires both binaries and dependencies)
Set-Alias git-bash "$TOOLS\git\git-bash.bat"
append-path	"$TOOLS\kdiff3"
append-path "$TOOLS\tortoisehg"               # download tortoise hg from http://tortoisehg.bitbucket.org/download/index.html (you can extract the msi by "msiexec /a tortoisehg-1.1.4-hg-1.6.4-x64.msi /qb TARGETDIR=f:\hg-temp")
append-path "$TOOLS\ruby-1.9.2-p0-i386-mingw32\bin" # http://rubyforge.org/frs/?group_id=167 (ruby-1.9.2-p0-i386-mingw32.7z)
append-path "$TOOLS\git\cmd"        # download portable git from http://code.google.com/p/msysgit/downloads/list
append-path "$TOOLS\veracity"
append-path "$TOOLS\NuGet"
append-path "$TOOLS\vim\vim73\"
$env:EDITOR = "vim"

# uuidgen.exe replacement
function uuidgen {
   [guid]::NewGuid().ToString('d')
}


# Load posh-git module
Import-Module $HOME\ps-scripts\posh-git\posh-git
Import-Module $HOME\ps-scripts\posh-hg\posh-hg

# SETUP PROMPT
function prompt {
	# start a new line after the last command. makes it clear
	Write-Host ""
	
	# http://markembling.info/view/my-ideal-powershell-prompt-with-git-integration
	$host.UI.RawUi.WindowTitle = $env:username + '@' + [System.Environment]::MachineName + ' ' + ($pwd)
	Write-Host($pwd) -nonewline -foregroundcolor Green 
        
    # Git Prompt
    $Global:GitStatus = Get-GitStatus
    Write-GitStatus $GitStatus
	
	# Mercurial Prompt
    $Global:HgStatus = Get-HgStatus
    Write-HgStatus $HgStatus
	
	# start writing the command at new line
	# coz it is easier to see the command in the same line.
	Write-Host ""
    return "$ "
}

if(-not (Test-Path Function:\DefaultTabExpansion)) {
    Rename-Item Function:\TabExpansion DefaultTabExpansion
}

# Set up tab expansion and include git expansion
function TabExpansion($line, $lastWord) {
    $lastBlock = [regex]::Split($line, '[|;]')[-1]
    
    switch -regex ($lastBlock) {
        # Execute git tab completion for all git-related commands
        'git (.*)' { GitTabExpansion $lastBlock }
		# mercurial and tortoisehg tab expansion
        '(hg|hgtk) (.*)' { HgTabExpansion($lastBlock) }
        # Fall back on existing tab expansion
        default { DefaultTabExpansion $line $lastWord }
    }
}


Enable-GitColors

Pop-Location