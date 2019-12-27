Import-Module posh-git
Import-Module oh-my-posh

# for scoop-completion, please use the mainfest in github.com/batkiz/backit bucket
$scoopdir = $(Get-Item $(Get-Command scoop).Path).Directory.Parent.FullName
Import-Module "$scoopdir\modules\scoop-completion"

Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# this theme is in ./PoshThemes
Set-Theme ys

# PowerShell parameter completion shim for the dotnet CLI 
Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock {
   param($commandName, $wordToComplete, $cursorPosition)
   dotnet complete --position $cursorPosition "$wordToComplete" | ForEach-Object {
      [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
   }
}

function vim {
   param($fileName = '.')
   wsl -e nvim $filename.Replace('\', '/').Replace('C:', '/mnt/c')
}

# cli trash
Set-Alias tr trash.exe
Set-Alias e explorer.exe