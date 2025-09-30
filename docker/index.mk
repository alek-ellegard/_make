
# ---
# Help target
mk-docker:
	@echo
	@echo "available:"
	@echo " | mk-* targets     | description           | runs"
	@echo "    mk-run          - run the application   -- docker-compose up -d --force-recreate --remove-orphans"
	@echo "    mk-stop         - stop the application  -- docker-compose down"
	@echo "    mk-clean-up     - clean up              -- docker-compose -v"
	@echo "    mk-build        - build image           -- docker build -t .."
	@echo "    mk-logs         - logs                  -- docker-compose logs"
	@echo "    --- "
	@echo "    mk-curt-build   - build with CURT for ECR"
	@echo "    mk-curt-publish - publish to ECR"
	@echo "    mk-clean        - clean build artifacts"
	@echo

# ----------------------------------------------------
# docker
#
mk-curt-build: ## curt-build p=<project_name> - with arm64 and latest
	echo "building: $(p)"
	curt build --project $(p) --platform linux/arm64/v8 --tag latest

.PHONY: curt-publish curt-publish-amd64
mk-curt-publish: ## curt-publish p=<project_name> - with arm64, latest, ap-east-1 
	@echo
	curt publish --project $(p) --platform linux/arm64/v8 --tag latest --region ap-east-1
	@echo

mk-curt-publish-amd64: ## curt-publish p=<project_name> - with amd64, latest, ap-east-1
	@echo
	curt publish --project $(p) --platform linux/amd64 --tag latest --region ap-east-1
	@echo

# ---------------------------------------------------
# docker-compose.yml

mk-run:
	@echo
	docker-compose up -d --force-recreate --remove-orphans
	@echo

mk-stop:
	@echo
	docker-compose down
	@echo

mk-clean-up:
	@echo
	docker-compose down -v
	@echo

mk-logs:
	@echo
	docker-compose logs 
	@echo

mk-build-run: ## curt-build and run with p=<image_name>
	@echo
	@echo "build-run: $(p)"
	@make mk-curt-build $(p)
	@make mk-run
	@echo

mk-restart:
	@echo
	make mk-clean-up
	make mk-run
	@echo

mk-restart-build:
	@echo
	make mk-clean-up
	make mk-build-run $(p)
	@echo
