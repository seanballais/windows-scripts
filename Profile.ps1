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
Enter-VsDevShell 46f3bcbf -SkipAutomaticLocation -DevCmdArguments "-arch=x64 -host_arch=x64 $no_banner_param"

oh-my-posh --init --shell pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression
