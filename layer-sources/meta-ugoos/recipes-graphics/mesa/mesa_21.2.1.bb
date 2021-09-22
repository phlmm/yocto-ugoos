require mesa.inc
#SRC_URI_ugoos-am6 = "git://gitlab.freedesktop.org/mesa/mesa.git;protocol=https;branch=main"
#SRCREV_ugoos-am6 = "${AUTOREV}"

SRC_URI = "https://mesa.freedesktop.org/archive/mesa-${PV}.tar.xz "
SRC_URI[sha256sum] = "2c65e6710b419b67456a48beefd0be827b32db416772e0e363d5f7d54dc01787"
DRIDRIVERS_append_ugoos-am6 = "auto"
PACKAGECONFIG_append_ugoos-am6 = " gallium gbm dri opengl gles egl "
PACKAGECONFIG_remove_ugoos-am6 = "vulkan va elf-tls"
