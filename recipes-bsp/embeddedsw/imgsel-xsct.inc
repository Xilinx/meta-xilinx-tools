# When this layer is included, we hard code how to build the firmware
IMGSEL_DEPENDS ?= "image-selector-xsct:do_deploy"
IMGSEL_MCDEPENDS ?= ""
IMGSEL_DEPLOY_DIR ?= "${DEPLOY_DIR_IMAGE}"
IMGSEL_IMAGE_NAME ?= "imgsel-${MACHINE}"

# We can skip the check, as we will build this
def check_imgsel_varsiables(d):
   return
