function jobsdone {
	wsl-notify "$1" "Job is done."
}

function findGitRepos {
	find . -name .git -type d -exec dirname {} \;
}

function gitfetchall {
	(cd $REPOSDIR
	for folder in $(findGitRepos) ; do 
		(git -C $folder fetch -p -P)
	done
	jobsdone "Fetch all") 
}

function ffall {
	(cd $REPOSDIR
	for folder in $(findGitRepos) ; do
		(cd $folder
		git fetch -p -P 
		git ff)
	done
	jobsdone "Fast-forward all")
}

