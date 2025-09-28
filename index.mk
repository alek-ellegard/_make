GIT_ROOT := $(shell git rev-parse --show-toplevel)

# ---
# ~/.zshrc 
# 
#   export MK_PATH=$(find ~/code -name "_make" -type d -print -quit)
#   export UI_SH=$(find $MK_PATH -name "ui.sh" -type f -print -quit)
#
# ---

# --
include $(MK_PATH)/base.mk
include $(MK_PATH)/general/*.mk
include $(MK_PATH)/checks/*.mk
include $(MK_PATH)/hatch/*.mk
include $(MK_PATH)/fzf/*.mk
include $(MK_PATH)/ui/*.mk
include $(MK_PATH)/ai/*.mk

test-index-mk:
	make dates
	make echo-mk-dir

echo-mk-dir:
	echo "$(MK_PATH)"

mk-help:
	@echo
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo
