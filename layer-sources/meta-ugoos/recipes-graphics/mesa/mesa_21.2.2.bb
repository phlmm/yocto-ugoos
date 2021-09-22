require mesa.inc
#SRC_URI_ugoos-am6 = "git://gitlab.freedesktop.org/mesa/mesa.git;protocol=https;branch=main"
#SRCREV_ugoos-am6 = "${AUTOREV}"

SRC_URI = "https://mesa.freedesktop.org/archive/mesa-${PV}.tar.xz "
SRC_URI[sha258sum] = "c4aaf1bf974217ed825e1c536de6ab72a4e266d44bcf69fc4ec499039f99e5c4"
DRIDRIVERS_append_ugoos-am6 = "auto"
PACKAGECONFIG_append_ugoos-am6 = " gallium gbm dri opengl gles egl "
PACKAGECONFIG_remove_ugoos-am6 = "vulkan va elf-tls"
