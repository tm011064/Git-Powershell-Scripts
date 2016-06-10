function Prompt-Push-To-Server
{
  $isFirstCommit = Read-Host 'is this the first commit to master for this branch? (y/n)'
  $hasDeletes = Read-Host 'does this commit contain deleted files? (y/n)'
  $message = Read-Host 'enter commit message'
  
  if ($message -eq '')
  {
    Write-Output "please provide a commit message"
    Exit
  }
  
  if ($hasDeletes -eq 'y')
  {
    git add -A .
  }
  else
  {
    git add .
  }
  
  git commit -m $message
  
  if ($isFirstCommit -eq 'y')
  {
    git push origin head -u
  }
  else
  {
    git push origin head
  }
}