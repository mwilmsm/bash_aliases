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

function brnch {
  (cd $REPOSDIR
  repos_list=""
  for folder in $(find_git_repos); do
    repos_list="$repos_list$(branch_status ${folder})\n"
  done
  echo -e ${repos_list} | column -t)
}

function branch_status {
  folder=$1
  cd ${folder}
  BRANCHNAME=`git branch --show-current`
  echo "${folder}\t\t${BRANCHNAME}\t\t$(git_rev_count ${BRANCHNAME})"
}

# Return whether or not your branch is up-to-date.
function git_rev_count {
  if [ -z $1 ]
  then
    BRANCHNAME=`git branch --show-current`
  else
    BRANCHNAME=$1
  fi
  if (( $(git rev-list HEAD...origin/${BRANCHNAME} --count) != 0))
 then
    echo "`tput setaf 1`out-of-sync with remote`tput sgr0`"
  else
    echo "`tput setaf 4`up-to-date`tput sgr0`"
  fi
}

# Add all files and commit with message
function gac {
  if [[ -z $@ ]]
  then
    echo "Usage: gac \"Commit Message\""
    return
  else
    BRANCHNAME=`git rev-parse --abbrev-ref HEAD`
    IFS=- read project jiraNo the_rest <<< "$BRANCHNAME"
    branchNo="${project}-${jiraNo}"
    commitMessage="${branchNo} $@ -mw"
    git add .
    git commit -m "${commitMessage}"
  fi
}
