#################################################################################
# Repo settings
#################################################################################
LAYERS_AMLOGIC ?= meta-meson
LAYERS_UGOOS ?= meta-ugoos 
LAYERS_OE ?= poky meta-openembedded
LAYERS_KODI ?= meta-kodi 	

OE_RELEASE ?= "hardknott-next"
AMLOGIC_RELEASE ?= "hardknott-next"
UGOOS_RELEASE ?= "master"
KODI_RELEASE ?= "master-next"

#################################################################################
# Yocto settings
#################################################################################
DISTRO ?= ""
MACHINE ?= "ugoos-am6"
IMAGE ?= ""
DEPLOY_PATH = shared/build/tmp/deploy/images/$(MACHINE)/
MACHINE_LIST = "ugoos-am6"
DISTRO_LIST = "poky'
IMAGE_LIST = "$(IMAGE), $(IMAGE)-dbg"
SDK_LIST = "yocto-toolchain full_sdk"
#################################################################################
# Bitbake  settings
#################################################################################
BB_CMD ?= bitbake 

#################################################################################
# Docker
#################################################################################
CONT_NAME ?= "crops/poky"
HOST_SHARED_DIR ?= $(PWD)/shared
DOCKER_RUN ?= docker run --rm -it --network host \
		-v $(HOST_SHARED_DIR):/workdir $(CONT_NAME) --workdir=/workdir
DOCKER_EXEC ?= /bin/bash -c "source /workdir/setupsdk; git config --global  \
		credential.helper 'store --file /workdir/.git-credentials';
DOCKER_EXEC_END ?= ";

#################################################################################
# SD Card
#################################################################################
BLK_DEV ?= /dev/null
BLK_DEV_CREATE ?= dd conv=fdatasync bs=4M status=progress
#################################################################################
# HW Target
#################################################################################
TARGET_IP := 192.168.2.100
.DEFAULT_GOAL := help
