
gh-feat-pr-merge: ## gh add, commit, push, pr, pr merge, pull
	git switch -c "$(b)"
	git add -A
	git commit
	git push
	gh pr create --fill
	gh pr merge -s -d
	git pull

