Write-Output "what do you want to do?`n"
Write-Output "  [p] - Push changes to master"
Write-Output "  [d] - Delete local branch"
Write-Output "  [c] - Create and check out branhc"
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
  
  Prompt-Delete
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