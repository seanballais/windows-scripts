# A shell script intended for Visual Studio 2022 that allows the display
# of the Visual Studio Developer banner inside the Visual Studio PowerShell
# terminal. This assumes that we are using windows-scripts/Profile.ps1 as
# our PowerShell profile.
#
# This is needed to make the VS terminal look as if it is set to use the
# default configuration given the profile we are using.
#
# To use this, the VS terminal configuration for PowerShell must be changed
# to the following:
#
# Shell Location: C:\Program Files\PowerShell\7\pwsh.exe
# Arguments: -NoExit -NoProfile -NoLogo -File "\path\to\sfb_vs_pwsh.ps1"
#
$Env:SFB_ENABLE_VS_DEV_BANNER = "true"
. "C:\Program Files\PowerShell\7\Profile.ps1"
