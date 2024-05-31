# Profile for PowerShell
# Enables Oh My ZSH-style command autocompletion and autosuggestion, and accessing Visual Studio CLI
# tools without using "Developer Powershell for VS 2022". This also sets up Oh My Posh.

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Autosuggestions
if (-not(Get-Module -ListAvailable PSReadLine)) {
    Import-Module PSReadLine
}

Set-PSReadLineOption -PredictionSource History

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# We could have used a parameter here, but we're using an environment variable instead, because
# this is a profile script, which is automatically loaded by PowerShell. Using an environment
# variable makes it easy to set options on this profile without always having to write a custom
# script that toggle options -- we can just set environment variables in the system.
[string]$no_banner_param = "-no_logo"
if ($Env:SFB_ENABLE_VS_DEV_BANNER -eq "true") {
    $no_banner_param = ""
}

# Allows us to use tools installed via Visual Studio.
Import-Module "C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
Enter-VsDevShell a009adc0 -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64 $no_banner_param"

oh-my-posh --init --shell pwsh --config "C:\Users\sean\AppData\Local\Programs\oh-my-posh\themes\jandedobbeleer.omp.json" | Invoke-Expression

# Set up pipenv prompt.
# Based on: https://github.com/pypa/pipenv/issues/4264#issuecomment-845445399
if ($env:PIPENV_ACTIVE -eq 1) {
    function _OLD_PROMPT { "" }
    Copy-Item -Path function:prompt -Destination function:_OLD_PROMPT

    $_PROMPT_PREFIX = (($env:VIRTUAL_ENV -split "\\")[-1] -split "-")[0]
    $pipenv_name = ((($(pip -V) -split ' ')[3]) -split '\\')[4]

    function prompt {
        Write-Host -NoNewline -ForegroundColor White "($_PROMPT_PREFIX) " 
        _OLD_PROMPT
    
    }
}

# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
