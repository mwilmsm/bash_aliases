# From https://codelearn.me/2019/01/13/wsl-windows-toast.html :
# Install Burnt-Toast in Powershell:
#    Install-Module -Name BurntToast
# Then make a file called wsl-notify:
#    #!/usr/bin/env -bash
#    powershell.exe "New-BurntToastNotification -Text \"$1\", \"$2\""
# Make it executable:
#    chmod +x wsl-notify
# Move it to /usr/bin:
#    mv wsl-notify /usr/bin/

# Uses the instructions above to show a toast message in Windows.
function jobs_done {
  wsl-notify "$1" "Job is done."
}


# Find all git repositories in the current folder (including nested ones).
function find_git_repos {
  find . -name .git -type d -exec dirname {} \;
}

# Run a command on all git folders in the current directory.
function git_all {
  for folder in $(find_git_repos); do
    git -C $folder "$@";
  done
}

# Run a git fetch on all repositories in ${REPOS_DIR}
function git_fetch_all {
  (cd ${REPOS_DIR}
  git_all fetch -p -P
  jobs_done "Fetch all") 
}


# Fast-forward all git repositories in ${REPOS_DIR}
function ff_all {
  (cd ${REPOS_DIR}
  git_all fetch -p -P 
  git_all merge --ff-only
  jobs_done "Fast-forward all")
}

# Search your history for the most recent uses of a command
function hgt {
  if [ -n $1 ]
  then
    if [ -z $2 ]
    then
      TAILCOUNT=10
    else
      TAILCOUNT=$2
    fi
    history | grep $1 | tail -"${TAILCOUNT}"
  fi
}

# Run a job silently in the background.
function hush {
  (eval "$@" &> /dev/null
  wait
  jobs_done "$1 complete") &
}
