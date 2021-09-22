DESCRIPTION = "A SD Image UGOOS AM6"

IMAGE_FEATURES += "ssh-server-openssh package-management hwcodecs"

PREFERRED_PROVIDER_virtual/egl = "mesa"
PREFERRED_PROVIDER_virtual/libgl = "mesa"
PREFERRED_PROVIDER_virtual/libgbm = "mesa"
PREFERRED_PROVIDER_virtual/libgles1 = "mesa"
PREFERRED_PROVIDER_virtual/libgles2 = "mesa"
PREFERRED_PROVIDER_virtual/libgles3 = "mesa"
PREFERRED_PROVIDER_virtual/mesa = "mesa"

INIT_MANAGER = "systemd"

EXTRA_IMAGE_FEATURES = "debug-tweaks"
DISTRO_FEATURES += "systemd "

IMAGE_INSTALL = "\
    packagegroup-core-boot \
    packagegroup-core-full-cmdline \
    packagegroup-core-ssh-openssh \
    openssh \
    pulseaudio \
    kernel-image \
    kernel-modules \
    kernel-devicetree \
    cpufrequtils \
    linux-firmware \
    opkg \
    opkg-collateral \
    mesa \ 
    vim \ 
    gnutls \
    ffmpeg \
    harfbuzz \
    dash \
    bash-completion \
    kodi \
    kodi-addon-inputstream-adaptive \
    kodi-addon-peripheral-joystick \
    kodi-addon-pvr-hts \
    kodi-systemd-service \
    i2c-tools \
    alsa-state \
    alsa-utils \
    g12-sound \
    coreutils \ 
    usbutils \
    fbset \
    fbset-modes \
    tzdata \
    transmission \
    transmission-web \
    udevil \ 
    ${CORE_IMAGE_EXTRA_INSTALL} \
    "
# 4G Rootfs
IMAGE_ROOTFS_SIZE = "4194304"

inherit core-image
IMAGE_CLASSES += "extrausers"

EXTRA_USERS_PARAMS = " \
	useradd -p 'ugoos' ugoos; \
	usermod -P 'root' root; \
"
