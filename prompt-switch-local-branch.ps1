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

function Prompt-Switch-Remote($mainBranch)
{
  $branches = git branch -a |
    Where-Object { $_.StartsWith("  remotes/origin/") } |
    foreach { $_.substring(17) } |
    Where-Object { $_ -notlike "HEAD ->*" }

  if ($branches.length -eq 0 -Or $branches -isnot [system.array])
  {
    Write-Host "No remote branches detected, exit..."
    Exit
  }

  $index = Select-Branch($branches);

  $name = Format-Branch-Name($branches[$index]);

  Write-Host "`n"

  git checkout $name
}
