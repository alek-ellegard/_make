# SSH Config Management
# Include this file: include ssh.mk

SSH_SCRIPT ?= ${MK_PATH}/ssh/ssh.sh
ENV_FILE ?= .env

mk-ssh:
	@bash -c "make | grep ssh"

ssh-var:
	@echo "ssh.sh $(ssh_script)"
	@echo ".env  $(ENV_FILE)"

# ensure script is executable
$(SSH_SCRIPT):
	@chmod +x $(SSH_SCRIPT)

.PHONY: ssh-add 
ssh-add: $(SSH_SCRIPT) ## ssh-add ENV_FILE=.env
	@ENV_FILE=$(ENV_FILE) $(SSH_SCRIPT) add

.PHONY: ssh-list
ssh-list: $(SSH_SCRIPT) ## ssh-list
	@$(SSH_SCRIPT) list

.PHONY: ssh-read
ssh-read: $(SSH_SCRIPT) ## ssh-read HOST=<host>
	@test -n "$(HOST)" || (echo "error: HOST required" >&2; exit 1)
	@$(SSH_SCRIPT) read $(HOST)

.PHONY: ssh-get
ssh-get: $(SSH_SCRIPT) ## ssh-get HOST=<host> PROP=<prop>
	@test -n "$(HOST)" || (echo "error: HOST required" >&2; exit 1)
	@test -n "$(PROP)" || (echo "error: PROP required" >&2; exit 1)
	@$(SSH_SCRIPT) get $(HOST) $(PROP)

# utility targets for common operations
.PHONY: ssh-connect
ssh-connect: $(SSH_SCRIPT) ## ssh-connect HOST=<host>
	@test -n "$(HOST)" || (echo "error: HOST required" >&2; exit 1)
	ssh $(HOST)

# get connection string for use in other targets
SSH_HOST = $(shell $(SSH_SCRIPT) get $(HOST) HostName 2>/dev/null)
SSH_USER = $(shell $(SSH_SCRIPT) get $(HOST) User 2>/dev/null || echo ec2-user)

.PHONY: ssh-info
ssh-info: ## ssh-info HOST=<host>
	@test -n "$(HOST)" || (echo "error: HOST required" >&2; exit 1)
	@echo "Host: $(HOST)"
	@echo "HostName: $(SSH_HOST)"
	@echo "User: $(SSH_USER)"
