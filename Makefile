include index.mk

rsync-caes:
	rm -rf ~/code/work/caes/_make
	rsync -av $(MK_PATH) ~/code/work/caes/

gh-feat-pr-merge:
	git switch -c "$(b)"
	git add -A
	git commit
	git push
	gh pr create --fill
	gh pr merge -s -d
