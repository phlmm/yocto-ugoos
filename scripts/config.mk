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
DISTRO ?= "poky"
MACHINE ?= "ugoos-am6"
IMAGE ?= "ugoos-kodi"
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
		-v $(HOST_SHARED_DIR):/work $(CONT_NAME) --workdir=/work
DOCKER_EXEC ?= /bin/bash -c "source /work/ugoos-init; git config --global  \
		credential.helper 'store --file /work/.git-credentials';
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
