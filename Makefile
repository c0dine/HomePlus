# Respring on make install
INSTALL_TARGET_PROCESSES = SpringBoard

# Comment this out to enable debug versions
#PACKAGE_VERSION=$(THEOS_PACKAGE_BASE_VERSION)

ARCHS = armv7 arm64 arm64e

# Target iOS 10+ Devices, and use the iOS 11.2 SDK
TARGET = iphone:clang:11.2:10.0

# Declare the location of the (patched) SDK we use
SYSROOT = $(THEOS)/sdks/iPhoneOS11.2.sdk

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HomePlus

# This code tells the compiler where to search for headers
# This means that I can use "#import "HPUtility.h" without being in the same
# 		directory as that file, anywhere in the project. 

dtoim = $(foreach d,$(1),-I$(d))

_IMPORTS =  $(shell /bin/ls -d ./HomePlusEditor/*/)
_IMPORTS +=  $(shell /bin/ls -d ./HomePlusEditor/*/*/)
_IMPORTS += $(shell /bin/ls -d ./)
IMPORTS = -I$./HomePlusEditor $(call dtoim, $(_IMPORTS))

# This code treats any .m file as a source file for the tweak and compiles/links it. 

SOURCES = $(shell find HomePlusEditor -name '*.m')



HomePlus_FILES = HomePlus.xm ${SOURCES}
HomePlus_CFLAGS += -fobjc-arc -w $(IMPORTS)

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += homeplusprefs
include $(THEOS_MAKE_PATH)/aggregate.mk


# If this tweak was compiled for iOS Simulator (It /does/ work), copy the
# 		apropriate files to the simject directory
ifneq (,$(filter x86_64 i386,$(ARCHS)))
setup:: clean all
	@rm -f /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(THEOS_OBJ_DIR)/$(TWEAK_NAME).dylib /opt/simject/$(TWEAK_NAME).dylib
	@cp -v $(PWD)/$(TWEAK_NAME).plist /opt/simject
endif