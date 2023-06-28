$scriptPath = $PSScriptRoot + "\git-branch-selector.ps1"
. $scriptPath

function Prompt-Switch($mainBranch)
{
  $branches = git branch
  
  if ($branches.length -eq 0 -Or $branches -isnot [system.array])
  {
    Write-Host "No local branches detected, exit..."
    Exit
  }
  
  $index = Select-Branch($branches);

  $name = Format-Branch-Name($branches[$index]);

  Write-Host "`n"

  git checkout $name
}
