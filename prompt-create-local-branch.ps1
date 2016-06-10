function Prompt-Create-Branch
{
  $name = Read-Host 'enter branch name'
  
  if ($name -eq '')
  {
    Write-Output "please provide a branch name"
    Exit
  }
  
  git fetch -pv
  git pull
  git checkout -b $name
}