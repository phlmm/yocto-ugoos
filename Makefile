name_main := $(word $(words $(MAKEFILE_LIST)),$(MAKEFILE_LIST))

include scripts/common.mk
include scripts/config.mk

#################################################################################
# Targets
#################################################################################

.PHONY: debug_image release_image sdk sdk_full help 

CLEAN_TARGETS ?= *.log sdk_full sdk release_image \
		 .do_repo_checkout debug_image .do_create_structure shared/

CLEAN_ALL_TARGETS ?= ${CLEAN_TARGETS} \
		callgrind* shared/

all: .do_create_structure .do_repo_checkout debug_image release_image sdk sdk_full


# Assumes the Makefile is cloned from the repo
.do_create_structure: ## Create basic folder structure
	@echo "$(RED)Creating project structure $(RESET)"
	@mkdir -p shared && \
	touch $@

.do_repo_checkout:  .do_create_structure ## Checkout all yocto git repos
	@echo "$(RED)Init all repos $(RESET)"
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	@pushd shared && \
	repo init -u file:///$(PWD) -b $(UGOOS_RELEASE) -m default.xml && \
	repo sync  && \
	repo start $(AMLOGIC_RELEASE) $(LAYERS_AMLOGIC) && \
	repo start $(OE_RELEASE) $(LAYERS_OE) && \
	repo start $(KODI_RELEASE) $(LAYERS_KODI) && \
	repo start $(UGOOS_RELEASE) $(LAYERS_UGOOS) && \
	popd && \
	touch $@


#################################################################################
# Image & SDK targets
#################################################################################
debug_image: .do_repo_checkout ## Builds the debug image (profiling, debugging and compiling tools, unstripped packages)
	@echo "$(RED)Starting debug image integration: $(RESET)"
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	$(call build, \
		@$(DOCKER_RUN) $(DOCKER_EXEC) MACHINE=$(MACHINE) DISTRO=$(DISTRO) \
		$(BB_CMD) $(IMAGE)-dbg $(DOCKER_EXEC_END), \
		$@_build.log, \
		$(HL)$@$(NC) taget)
	@echo "$(GREEN)Build artifacts are in $(DEPLOY_PATH)$(RESET)" \
	&& touch $@

release_image: .do_repo_checkout ## Builds the release (stripped down) image
	@echo "$(RED)Starting release image integration $(RESET)"
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	$(call build, \
		@$(DOCKER_RUN) $(DOCKER_EXEC) MACHINE=$(MACHINE) DISTRO=$(DISTRO) \
		$(BB_CMD) $(IMAGE) $(DOCKER_EXEC_END), \
		$@_build.log, \
		$(HL)$@$(NC) taget)
	@echo "$(GREEN)Build artifacts are in $(DEPLOY_PATH)$(RESET)" \
	&& touch $@

sdk: ## Builds meta-toolchain
	@echo "$(RED)Exporting minimal SDK: $(RESET)"
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	$(call build, \
		@$(DOCKER_RUN) $(DOCKER_EXEC) MACHINE=$(MACHINE) DISTRO=$(DISTRO) \
		$(BB_CMD) meta-toolchain $(DOCKER_EXEC_END), \
		$@_build.log, \
		$(HL)$@$(NC) taget)
	@echo "$(GREEN)Build artifacts are in $(DEPLOY_PATH)sdk$(RESET)" \
	&& touch $@

sdk_full: ## Builds the SDK for the $(IMAGE)-dbg and populates it
	@echo "$(RED)Exporting populated SDK: $(RESET)"
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	$(call build, \
		@$(DOCKER_RUN) $(DOCKER_EXEC) MACHINE=$(MACHINE) DISTRO=$(DISTRO) \
		$(BB_CMD) -c populate_sdk $(IMAGE)-dbg $(DOCKER_EXEC_END), \
		$@_build.log, \
		$(HL)$@$(NC) taget)
	@echo "$(GREEN)Build artifacts are in $(DEPLOY_PATH)sdk$(RESET)" \
	&& touch $@


all_from_scratch:
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	@echo "$(RED)Rebuilding from scratch: $(RESET)"
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	@$(MAKE) clean_all && \
	$(MAKE) .do_create_structure && \
	$(MAKE) .do_repo_checkout && \
	$(call build, \
		$(DOCKER_RUN) $(DOCKER_EXEC) \
		MACHINE=$(MACHINE) DISTRO=$(DISTRO) \
		$(BB_CMD) $(IMAGE) $(IMAGE)-dbg meta-toolchain -c populate_sdk \
		$(DOCKER_EXEC_END), \
		$@.log, \
		$(HL) $@ $(NC) target)

#################################################################################
# Flash SD Card
#################################################################################
flash_release_sd:  ## flash release iamge to dev passed as env $(BLK_DEV)
	@$(BLK_DEV_CREATE) if=$(DEPLOY_PATH)/$(IMAGE)-$(MACHINE).wic of=$(BLK_DEV)

flash_debug_sd:  ## flash release iamge to dev passed as env $(BLK_DEV)
	@$(BLK_DEV_CREATE) if=$(DEPLOY_PATH)/$(IMAGE)-dbg-$(MACHINE).wic of=$(BLK_DEV)


################################################################################
# Clean
################################################################################
clean: 	## Clean build only
	@echo "$(RED)Cleaning up build only $(RESET)"
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	@rm -fr ${CLEAN_TARGETS}
clean_all:  ## Clean build + download cache (downloading takes ~51 minutes on wifi)
	@echo "$(RED)Cleaning up everything $(RESET)"
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	@rm -fr ${CLEAN_ALL_TARGETS}

