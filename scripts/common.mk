#################################################################################
# Functions
#################################################################################
SHELL=/bin/bash

ifneq (,$(findstring xterm,${TERM}))
	BLACK        := $(shell tput -Txterm setaf 0)
	RED          := $(shell tput -Txterm setaf 1)
	GREEN        := $(shell tput -Txterm setaf 2)
	YELLOW       := $(shell tput -Txterm setaf 3)
	LIGHTPURPLE  := $(shell tput -Txterm setaf 4)
	PURPLE       := $(shell tput -Txterm setaf 5)
	BLUE         := $(shell tput -Txterm setaf 6)
	WHITE        := $(shell tput -Txterm setaf 7)
	RESET := $(shell tput -Txterm sgr0)
else
	BLACK        := $(shell tput  setaf 0)
	RED          := $(shell tput  setaf 1)
	GREEN        := $(shell tput  setaf 2)
	YELLOW       := $(shell tput  setaf 3)
	LIGHTPURPLE  := $(shell tput  setaf 4)
	PURPLE       := $(shell tput  setaf 5)
	BLUE         := $(shell tput  setaf 6)
	WHITE        := $(shell tput  setaf 7)
	RESET := $(shell tput  sgr0)
endif

TARGET_COLOR := $(BLUE)

assert-command-present=$(if $(shell which $1),,$(error '$1' missing and needed \
       	for this build))

ifdef MAKE_TERMOUT
  ESC:=$(shell printf '\033')
  GREEN:=$(ESC)[1;32m
  RED:=$(ESC)[1;31m
  HL:=$(ESC)[0;33m
  NC:=$(ESC)[0m
else
  GREEN:=
  RED:=
  HL:=
  NC:=
endif

ifneq ($(VERBOSE),1)
  MAKEFLAGS += --quiet

  # build - Run a build command
  # $(1): Command to execute
  # $(2): Logfile name
  # $(3): Textual description of the task
  define build
	echo -n "Building $(strip $(3)) [$(HL)$(CURDIR)/$(strip $(2))$(NC)] ..."
	$(strip $(1)) >> $(strip $(2)) 2>&1; \
	(ERR=$$?; if [ $$ERR = 0 ]; then \
		echo " $(GREEN)OK$(NC)"; \
	else \
		echo " $(RED)FAILED$(NC)"; \
		echo "For details see $(HL)$(CURDIR)/$(strip $(2))$(NC)"; \
		echo ""; \
	fi; exit $$ERR)
  endef

  # clean - Run a clean command
  # $(1): Files to remove
  # $(2): Textural description of the task
  define clean
	@echo "Cleaning $(strip $(2)) ..."
	-rm -rf $(strip $(1))
  endef
else
  define build
	$(strip $(1)) >> $(strip $(2)) 2>&1
  endef

  define clean
	-rm -rf $(strip $(1))
  endef
endif

#################################################################################
# Dependencies
#################################################################################
$(call assert-command-present, repo)
$(call assert-command-present, awk)
$(call assert-command-present, dd)

################################################################################
# Help
################################################################################
help:
	@echo ""
	@echo "		${BLACK}:: ${RED}Ugoos yocto makefile${RESET} ${BLACK}::${RESET}"
	@echo ""
	@echo " Project initialization automation for $(WHITE)$(MACHINE_LIST)" \
		"$(RESET)"
	@echo ""
	@echo " It has the capability to generate $(WHITE)$(IMAGE_LIST)$(RESET) and "
	@echo " $(WHITE)$(SDK_LIST)$(RESET) without any constrains on host machine distribution."
	@echo ""
	@echo " Make sure you have a recent cropps/poky container in your docker repository. Or allow"
	@echo " configure your docker installation to have userspace internet access."
	@echo ""
	@echo ""
	@echo " Desired MACHINE, IMAGE and DISTRO could also passed from the environment"
	@echo " For $(WHITE)$(DISTRO)$(RESET), the images available are $(WHITE)" \
		"$(IMAGE_LIST)$(RESET)"
	@echo "${BLACK}-----------------------------------------------------------------------------${RESET}"
	@grep -E '^[a-zA-Z_0-9%-]+:.*?## .*$$' ${name_main} | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "${TARGET_COLOR}%-30s${RESET} %s\n", $$1, $$2}'
