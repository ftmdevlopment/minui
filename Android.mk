LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES := graphics.c graphics_fbdev.c events.c \
	resources.c

ifeq ($(TARGET_USE_ADF),true)
  LOCAL_SRC_FILES += graphics_adf.c
endif

$(info "C_ROOT: $(C_ROOT)")
$(info "LOCAL_PATH: $(LOCAL_PATH)")
$(info "NDK_PROJECT_PATH: $(LOCAL_PATH)")

ifneq ($(C_ROOT),)
  LOCAL_C_INCLUDES += \
    $(C_ROOT)/uapi \
    $(C_ROOT)/libpng \
    $(C_ROOT)/zlib

  ifeq ($(TARGET_USE_ADF),true)
    LOCAL_C_INCLUDES += $(C_ROOT)/adf/libadf
  endif
endif

ifeq ($(TARGET_USE_ADF),true)
  LOCAL_WHOLE_STATIC_LIBRARIES += libadf
endif

LOCAL_MODULE := libminui

# This used to compare against values in double-quotes (which are just
# ordinary characters in this context).  Strip double-quotes from the
# value so that either will work.

ifeq ($(subst ",,$(TARGET_RECOVERY_PIXEL_FORMAT)),RGBX_8888)
  LOCAL_CFLAGS += -DRECOVERY_RGBX
endif
ifeq ($(subst ",,$(TARGET_RECOVERY_PIXEL_FORMAT)),BGRA_8888)
  LOCAL_CFLAGS += -DRECOVERY_BGRA
endif

ifneq ($(TARGET_RECOVERY_OVERSCAN_PERCENT),)
  LOCAL_CFLAGS += -DOVERSCAN_PERCENT=$(TARGET_RECOVERY_OVERSCAN_PERCENT)
else
  LOCAL_CFLAGS += -DOVERSCAN_PERCENT=0
endif

ifeq ($(TARGET_USE_DOUBLE_BUFFER),true)
  LOCAL_CFLAGS += -DUSE_DOUBLE_BUFFER
endif

include $(BUILD_STATIC_LIBRARY)
