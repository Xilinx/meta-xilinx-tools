# When this layer is included, we hard code how to build the firmware
IMGRCRY_DEPENDS ?= "image-recovery:do_deploy"
IMGRCRY_MCDEPENDS ?= ""
IMGRCRY_DEPLOY_DIR ?= "${DEPLOY_DIR_IMAGE}"
IMGRCRY_IMAGE_NAME ?= "imgrcry-${MACHINE}"

# We can skip the check, as we will build this
def check_imgrcry_varsiables(d):
   return
