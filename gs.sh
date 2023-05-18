#! /bin/bash

masterBranch=${1}

if [[ -z "$masterBranch" ]]
then

  branches=$(git for-each-ref refs/heads  | cut -d/ -f3-)
  
  [[ $branches =~ (^|[[:space:]])"main"($|[[:space:]]) ]] && hasMain=1 || hasMain=0
  [[ $branches =~ (^|[[:space:]])"master"($|[[:space:]]) ]] && hasMaster=1 || hasMaster=0

  if [[ "$hasMain" == 1 ]]
  then
    masterBranch="main"

    if [[ "$hasMaster" == 1 ]]
    then
      echo "both main and master exist, choosing main"
    fi

  elif [[ "$hasMaster" == 1 ]]
  then
    masterBranch="master"
  fi

fi

echo "Choose option for branch '$masterBranch'"
echo "  [p] - push changes to $masterBranch"
echo "  [d] - delete local branch"
echo "  [c] - create and check out branch"
echo "  [s] - switch/checkout branch"
echo "  [ESC] exit"

read -r -n 1 -s choice

if [[ $choice == "p" ]]
then
  
  echo "enter commit message"
  read -r message

  git add .
  git commit -m "$message"
  git push origin head

elif [[ $choice == "c" ]]
then

  echo "enter branch name"
  read -r name

  git fetch -pv
  git pull
  git checkout -b "$name"

elif [[ $choice == "d" ]]
then
  
  echo "select the branch to delete:"

  select branch in $(git for-each-ref refs/heads  | cut -d/ -f3-)
  do
    read -p "Delete branch $branch -> you sure? (y/n)" -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
      exit 1
    fi

    git checkout "$masterBranch"
    git pull
    git fetch -p
    git branch -D "$branch"
    git branch

    break
  done

elif [[ $choice == "s" ]]
then

  echo "select the branch to checkout:"

  select branch in $(git for-each-ref refs/heads  | cut -d/ -f3-)
  do    
    git checkout "$branch"
    break
  done
else
  echo "Command $choice not found"
fi
