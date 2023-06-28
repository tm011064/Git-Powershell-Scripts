$scriptPath = $PSScriptRoot + "\git-branch-selector.ps1"
. $scriptPath

function Prompt-Delete($mainBranch)
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
  
  $confirmation = Read-Host "Delete branch ""$($name)"" -> you sure? {y/n)"
  if ($confirmation -eq 'y')
  {
    git checkout $mainBranch
    git pull
    git fetch -p
    git branch -D $name
    git branch
  }
}
