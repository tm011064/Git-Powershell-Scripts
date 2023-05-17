function Prompt-Push-To-Server
{
  $message = Read-Host 'enter commit message'
  
  if ($message -eq '')
  {
    Write-Output "please provide a commit message"
    Exit
  }

  git add .
  git commit -m $message
  git push origin head
}