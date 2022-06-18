#!/usr/bin/bash

CONT_NAME="crops/poky"
CUR_DIR=`realpath .`
HOST_SHARED_DIR=${CUR_DIR}/shared

if [[ -z "${SRC_DIR}" ]]; then
  SHARED_SRC_CMD=""
else
  SRC_DIR=`realpath ${SRC_DIR}`
  SHARED_SRC_CMD="-v ${SRC_DIR}:/src"
fi
MACH="ugoos-am6"
DISTR="poky-bleeding"
TOOLCHAIN_DIR=""
#export BB_ENV_EXTRAWHITE=\"\${BB_ENV_EXTRAWHITE} DEV_SRC\"; 
DOCKER_EXEC="source ugoos-init;export TOOLCHAIN_BASE=${TOOLCHAIN_DIR}; \
       	export MACHINE=${MACH};export DISTRO=${DISTR}; \
      	git config --global credential.helper 'store --file /work/.git-credentials'; \
	/bin/bash"

docker run --rm -it --network host -v ${HOST_SHARED_DIR}:/work ${SHARED_SRC_CMD}   ${CONT_NAME} --workdir=/work /bin/bash -c "${DOCKER_EXEC}"
