function Write-Header($branches)
{
  Write-Host "`Your local branches are:`n"
  
  $branches
  
  Write-Host -NoNewLine "`select branch to delete [up-down arrows]: " $text 
}

function Clear-Text($length)
{
  while ($length -gt 0)
  {
    Write-Host -NoNewLine " "
    $length -= 1;
  }
}

function Format-Branch-Name($name)
{
  $name = $name -replace "\* ", "";
  return $name.Trim();
}

function Prompt-Delete
{
  $branches = git branch
  
  if ($branches.length -eq 0 -Or $branches -isnot [system.array])
  {
    Write-Host "No local branches detected, exit..."
    Exit
  }
  
  $index = 0;
  
  Write-Header($branches);
  
  $lastBranchName = $branches[$index];
  
  $posY = [console]::CursorTop
  $posX = [console]::CursorLeft
  
  Write-Host -NoNewline (Format-Branch-Name($branches[$index]));
  $key = [console]::ReadKey($true);
  
  while ($key.Key -ne "Enter")
  {
    if ($key.Key -eq 'UpArrow')
    {
      $index -= 1;
      if ($index -lt 0)
      {
        $index = $branches.length - 1;
      }
    }
    elseif ($key.Key -eq 'DownArrow')
    {
      $index += 1;
      if ($index -eq $branches.length)
      {
        $index = 0;
      }
    }
    elseif ($key.Key -eq 'Escape')
    {
      Write-Host "`n"
      Exit
    }
    
    [console]::setcursorposition($posX,$posY);
    Clear-Text($lastBranchName.length);
    [console]::setcursorposition($posX,$posY);
    
    $lastBranchName = $branches[$index];
    
    Write-Host -NoNewline (Format-Branch-Name($branches[$index]));
    $key = [console]::ReadKey($true);
  }

  $name = Format-Branch-Name($branches[$index]);
  
  Write-Host "`n"
  
  $confirmation = Read-Host "Delete branch ""$($name)"" -> you sure? {y/n)"
  if ($confirmation -eq 'y')
  {
    git checkout master
    git pull
    git fetch -p
    git branch -D $name
    git branch
  }
}

























