# Windows Scripts
This is a collection of scripts I use in Windows. I am sharing this in the hopes that this will be of benefit to others as well.

I am using Windows Terminal, PowerShell 7, Visual Studio 2022, and Oh My Posh. As such, the scripts here are assuming such environment. The scripts are also located in two different folders:

| **Script**                                        | Location                               |
|---------------------------------------------------|----------------------------------------|
| `Profile1.ps1`                                    | `C:\Program Files\PowerShell\7\`       |
| Others (i.e. `sfb_cmd.bat` and `sfb_vs_pwsh.ps1`) | `C:\Program Files\Custom CLI Scripts\` |

`Profile1.ps1` is saved inside `C:\Program Files\PowerShell\7` since it is my global PowerShell profile. You may learn more about PowerShell profiles [here](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.2). `Custom CLI Scripts\` is a folder I have created for global storage of scripts. This will allow the scripts in the folder to be accesible by all users.

`Profile1.ps1` and `sfb_cmd.bat` have been created to allow me to access Visual Studio CLI tools without resorting to developer versions of PowerShell and Command Prompt provided by Visual Studio (i.e. Developer PowerShell for VS 2022 and Developer Command Prompt for VS 2022). Since loading up the VS configuration to allow access to the Visual Studio CLI tools causes the VS developer CLI session banner to show up, `Profile1.ps1` has been written to disable this banner by default unless toggled on by setting a `SFB_ENABLE_VS_DEV_BANNER` to `"true"`. The profile is also written to enable Oh My ZSH-style autosuggestions and autocompletion and Oh My Posh with the Jandedobbeleer theme. On the other hand, `sfb_vs_pwsh.ps1` is used to toggle the banner on when opening a Developer PowerShell in Visual Studio. Note that opening a PowerShell session in Visual Studio loads up our `Profile.ps1` PowerShell profile as well.

## Setting Up
In Windows Terminal, to set up PowerShell to use our profile, just have a PowerShell terminal profile that opens up PowerShell 7. No need to set more configurations, since PowerShell will automatically load up the profile.

On the other hand, the Command Prompt profile in Windows Terminal will have to be modified a bit. We just need to modify the Command line executable in the profile to be set to:

```
cmd.exe /k "C:\Program Files\Custom CLI Scripts\sfb_cmd.bat"
```

Finally, to integrate `sfb_vs_pwsh.ps1` with the Visual Studio PowerShell terminal, simply do the following:

1) Open the terminal options in Visual Studio (`Tools > Options > Environment > Terminal`).
2) Click on the "Developer PowerShell" profile.
3) Change the value in "Shell Location" to: `C:\Program Files\PowerShell\7\pwsh.exe`
4) Change the value in "Arguments" to: `-NoExit -NoProfile -NoLogo -File "C:\Program Files\Custom CLI Scripts\sfb_vs_pwsh.ps1"`
5) Click "Apply".

And that's it!

## Questions and Discussions
For questions and related discussions on these scripts, please feel free to [write an issue](https://github.com/seanballais/windows-scripts/issues/new) in this repository or contact me via Twitter ([@seanballais](https://twitter.com/seanballais)) or email ([sean@seanballais.com](mailto:sean@seanballais.com?subject=Regarding%20your%20Windows%20Scripts)).

## Credits
The scripts in this repository is created by [Sean Ballais]([@seanballais](https://twitter.com/seanballais)).

## License
The scripts here are licensed under the [MIT license](https://choosealicense.com/licenses/mit/).
