
include ~/code/code/_make/base.mk
include ~/code/code/_make/general/*.mk
include ~/code/code/_make/checks/*.mk
include ~/code/code/_make/hatch/*.mk
include ~/code/code/_make/fzf/*.mk
include ~/code/code/_make/ui/*.mk
include ~/code/code/_make/ai/*.mk

test-index-mk:
	make dates
