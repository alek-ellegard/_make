# ---


# ---
# CRUD
#

# create
w-readme:
	@nvim README.md

# read
ra:
	@make files-bat depth=$(depth) files="$(files)"

r-readme:
	@bat README.md
	@echo
	@echo "nb: cat-readme also available"
	@echo

cat-readme:
	@bat README.md

echo-git-root:
	echo "$(MK_PATH)"

