function Format-Branch-Name($name)
{
  $name = $name -replace "\* ", "";
  return $name.Trim();
}

$branches = git branch | ForEach-Object { Format-Branch-Name($PSItem) }

if ($branches.length -eq 0)
{
  Write-Host "No local branches detected, exit..."
  exit
} elseif ($branches -isnot [system.array]) {
    $branches = @($branches)
}

$mainBranch = if ($branches -contains "main") {"main"} elseif ($branches -contains "master") {"master"} else {""}
if ($mainBranch -eq "")
{
  Write-Host "No main branch detected, exit..."
  exit
}

Write-Output "Choose option for branch '$($mainBranch)'`n"
Write-Output "  [p] - Push changes to '$($mainBranch)'"
Write-Output "  [d] - Delete local branch"
Write-Output "  [s] - Switch local branch"
Write-Output "  [r] - Switch remote branch"
Write-Output "  [c] - Create and check out branch"
Write-Output "  [ESC] exit"

$choice = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown");

if ($choice.Character -eq "c")
{
  $scriptPath = $PSScriptRoot + "\prompt-create-local-branch.ps1"
  . $scriptPath
  
  Prompt-Create-Branch
}
elseif ($choice.Character -eq "d")
{
  $scriptPath = $PSScriptRoot + "\prompt-delete-local-branch.ps1"
  . $scriptPath
  
  Prompt-Delete($mainBranch)
}
elseif ($choice.Character -eq "s")
{
  $scriptPath = $PSScriptRoot + "\prompt-switch-local-branch.ps1"
  . $scriptPath

  Prompt-Switch
}
elseif ($choice.Character -eq "r")
{
  $scriptPath = $PSScriptRoot + "\prompt-switch-local-branch.ps1"
  . $scriptPath

  Prompt-Switch-Remote
}
elseif ($choice.Character -eq "p")
{
  $scriptPath = $PSScriptRoot + "\prompt-push-to-server.ps1"
  . $scriptPath
  
  Prompt-Push-To-Server
}
else
{
  Write-Output "exit";
}
