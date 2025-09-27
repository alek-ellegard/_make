GIT_ROOT := $(shell git rev-parse --show-toplevel)
MK_DIR := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

include $(MK_DIR)/base.mk
include $(MK_DIR)/general/*.mk
include $(MK_DIR)/checks/*.mk
include $(MK_DIR)/hatch/*.mk
include $(MK_DIR)/fzf/*.mk
include $(MK_DIR)/ui/*.mk
include $(MK_DIR)/ai/*.mk

test-index-mk:
	make dates
	make echo-mk-dir

echo-mk-dir:
	echo "$(MK_DIR)"
