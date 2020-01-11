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


# Run a git fetch on all repositories in ${REPOS_DIR}
function git_fetch_all {
  (cd ${REPOS_DIR}
  for folder in $(find_git_repos) ; do 
    (git -C ${folder} fetch -p -P)
  done
  jobs_done "Fetch all") 
}


# Fast-forward all git repositories in ${REPOS_DIR}
function ff_all {
  (cd ${REPOS_DIR}
  for folder in $(find_git_repos) ; do
    (cd ${folder}
    git fetch -p -P 
    git ff)
  done
  jobs_done "Fast-forward all")
}
