#requires -module @{ModuleName='PowerLine';ModuleVersion='1.1.0'}, @{ModuleName='PSGit'; ModuleVersion='2.0.3'}
using module PowerLine
using namespace PowerLine

# Make sure we're using the PowerLine custom use extended characters:
[PowerLine.Block]::LeftCap = [char]0xe0b0
[PowerLine.Block]::RightCap = [char]0xe0b2
[PowerLine.Block]::LeftSep = [char]0xe0b1
[PowerLine.Block]::RightSep = [char]0xe0b3

$global:PowerLinePrompt = 1,
    (
        [PowerLine.BlockCache]::Column, # Right align this line
        @{ bg = "DarkGray"; fg = "White"; text = { Get-Elapsed } },
        @{ bg = "Black";    fg = "White"; text = { Get-Date -f "T" } }
    ),
    (
        @{ bg = "Blue";     fg = "White"; text = { $MyInvocation.HistoryId } },
        @{ bg = "Cyan";     fg = "White"; text = { [PowerLine.Block]::Gear * $NestedPromptLevel } },
        @{ bg = "Cyan";     fg = "White"; text = { if($pushd = (Get-Location -Stack).count) { "$([char]187)" + $pushd } } },
        @{ bg = "DarkBlue"; fg = "White"; text = { $pwd.Drive.Name } },
        @{ bg = "DarkBlue"; fg = "White"; text = { Split-Path $pwd -leaf } },
        # This requires my PoshCode/PSGit module and the use of the SamplePSGitConfiguration -- remove the last LeftCap in that.
        @{ bg = "DarkCyan";               text = { ([PowerLine.Line]@(Get-GitStatusPowerline)).ToString() -replace [PowerLine.Block]::LeftCap+'$' } }
    )

Set-PowerLinePrompt -Title -CurrentDirectory
