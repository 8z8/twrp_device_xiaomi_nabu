#
# Copyright (C) 2020 The Android Open Source Project
# Copyright (C) 2020 The TWRP Open Source Project
# Copyright (C) 2020 SebaUbuntu's TWRP device tree generator
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Bootloader
BOARD_VENDOR := xiaomi
PRODUCT_PLATFORM := msmnile
TARGET_SOC := msmnile
TARGET_BOOTLOADER_BOARD_NAME := nabu
TARGET_NO_BOOTLOADER := true

# Platform
TARGET_BOARD_PLATFORM := msmnile
TARGET_BOARD_PLATFORM_GPU := qcom-adreno640
QCOM_BOARD_PLATFORMS += msmnile
BOARD_USES_QCOM_HARDWARE := true

DEVICE_PATH := device/xiaomi/nabu

BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_USES_BUILD_COPY_HEADERS := true

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := kryo
TARGET_CPU_VARIANT_RUNTIME := kryo485
TARGET_CPU_SMP := true

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a76
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a76
TARGET_BOARD_SUFFIX := _64
TARGET_USES_64_BIT_BINDER := true

# Assert
TARGET_OTA_ASSERT_DEVICE := nabu

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Dex
ifeq ($(HOST_OS),linux)
  ifneq ($(TARGET_BUILD_VARIANT),eng)
    WITH_DEXPREOPT ?= true
  endif
endif

# Battery
BOARD_GLOBAL_CFLAGS += -DBATTERY_REAL_INFO
HEALTHD_USE_BATTERY_INFO := true

# File systems
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_COPY_OUT_VENDOR := vendor

# Partitions
BOARD_EXT4_SHARE_DUP_BLOCKS := true
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 134217728
BOARD_DTBOIMAGE_PARTITION_SIZE := 33554432
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 100663296
BOARD_SUPER_PARTITION_SIZE := 9126805504 # TODO: Fix hardcoded value
BOARD_SUPER_PARTITION_GROUPS := xiaomi_dynamic_partitions
BOARD_XIAOMI_DYNAMIC_PARTITIONS_PARTITION_LIST := system system_ext product vendor odm
BOARD_XIAOMI_DYNAMIC_PARTITIONS_SIZE := 9122611200 # TODO: Fix hardcoded value

# A/B
AB_OTA_UPDATER := true
TW_INCLUDE_REPACKTOOLS := true

# DRM
TARGET_ENABLE_MEDIADRM_64 := true

# Metadata
BOARD_USES_METADATA_PARTITION := true
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Kernel
BOARD_KERNEL_CMDLINE := \
    ttyMSM0,115200n8 \
    earlycon=msm_geni_serial,0xa90000 \
    androidboot.hardware=qcom \
    androidboot.console=ttyMSM0 \
    androidboot.memcg=1 \
    lpm_levels.sleep_disabled=1 \
    video=vfb:640x400,bpp=32,memsize=3072000 \
    msm_rtb.filter=0x237 \
    service_locator.enable=1 \
    swiotlb=2048 \
    androidboot.usbcontroller=a600000.dwc3 \
    androidboot.selinux=permissive \
    androidboot.vbmeta.avb_version=1.0 \
    androidboot.boot_devices=soc/1d84000.ufshc

TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_CLANG_COMPILE := true
BOARD_KERNEL_IMAGE_NAME := Image.gz-dtb
BOARD_BOOT_HEADER_VERSION := 3
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/prebuilt/kernel

ifeq ($(strip $(TARGET_PREBUILT_KERNEL)),)
TARGET_KERNEL_SOURCE := kernel/xiaomi/nabu
TARGET_KERNEL_CONFIG := nabu_user_defconfig
endif

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 4096
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

# 16:10 Screen
TARGET_SCREEN_WIDTH := 2560
TARGET_SCREEN_HEIGHT := 1600

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_USES_MKE2FS := true
BOARD_SUPPRESS_SECURE_ERASE := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --set_hashtree_disabled_flag
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 2

# Treble
BOARD_VNDK_VERSION := current

#Vendor Boot
PRODUCT_COPY_FILES += \
	$(DEVICE_PATH)/recovery/root/fstab.qcom:$(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.qcom

TARGET_RECOVERY_INITRC := $(DEVICE_PATH)/recovery/root/init.recovery.qcom.rc
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
DEVICE_MANIFEST_FILE := $(DEVICE_PATH)/manifest.xml

# Hack: prevent anti rollback
# Crypto
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_CRYPTO_FBE := true
TW_INCLUDE_FBE_METADATA_DECRYPT := true
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 127
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
BOARD_USES_QCOM_FBE_DECRYPTION := true
PRODUCT_ENFORCE_VINTF_MANIFEST := true


# TWRP Configuration
TW_DEVICE_VERSION := Xiaomi_Pad_5-bm0x_Testing
TW_THEME := portrait_hdpi
TW_HAS_NO_RECOVERY_PARTITION := true
TW_HAS_NO_BOOT_PARTITION := true
RECOVERY_SDCARD_ON_DATA := true
TARGET_RECOVERY_QCOM_RTC_FIX := true
TW_EXCLUDE_DEFAULT_USB_INIT := true
TW_EXTRA_LANGUAGES := true
TW_INCLUDE_NTFS_3G := true
TW_USE_TOOLBOX := true
TW_INCLUDE_RESETPROP := true
TW_INPUT_BLACKLIST := "hbtp_vm"
TW_BRIGHTNESS_PATH := "/sys/class/backlight/panel0-backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 1200
TWRP_INCLUDE_LOGCAT := true
TARGET_USES_LOGD := true
TARGET_USES_MKE2FS := true
TW_NO_SCREEN_BLANK := true