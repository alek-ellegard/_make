ai: ## init claude with base context
	@claude @$(MK_PATH)ai/context/base.md @./.claude

ai-py: ## init claude session for py project
	@mkdir -p .claude
	@rsync -av $(MK_PATH)ai/context/python/.claude/* .claude
	@make ai

cursor:
	cursor

claude:
	claude $(p)

mk-ai:
	@echo
	@echo "code:"
	@echo "  code"
	@echo
	@echo "claude:"
	@echo "  claude $(p)"
	@echo
