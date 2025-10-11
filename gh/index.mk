gh-feat-pr-merge: ## b=<branch> -- gh add, commit, push, pr, pr merge, pull
	@read -p "continue? [y/Enter] " response; \
	if [ -z "$$response" ] || [ "$$response" = "y" ]; then \
		echo "proceeding..."; \
		make _gh-feat-pr-merge b="$(b)"; \
	else \
		echo "aborted by user."; \
		exit 1; \
	fi


_gh-feat-pr-merge:
	@make _check-b

# quick check point 
_check-b: # TODO: fix (use '~/code/work/test-pr')
	if [ -z "$(b)" ]; then \
		read -p "branch name:" branch_name; \
		if [ -z "$$branch_name" ]; then \
			echo "proceeding..."; \
			__gh-feat-pr-merge b="$$branch_name"
		fi; \
	else \
		echo "no branch name - b=<branch_name>"; \
		exit 1; \
	fi

# main logic with guaranteed branch_name / b
__gh-feat-pr-merge:
	git switch -c "$(b)"
	@make _git-ac
	git push
	gh pr create --fill
	gh pr merge -s -d
	git pull

_git-ac:
	@read -p "add -A && commit? [y/Enter] " response; \
	if [ -z "$$response" ] || [ "$$response" = "y" ]; then \
		echo "proceeding..."; \
		git add -A; \
		git commit; \
	fi




