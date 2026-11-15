ARCHS = arm64
TARGET := iphone:clang:latest:15.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FBClassicPlayer
FBClassicPlayer_FILES = Tweak.x
FBClassicPlayer_CFLAGS = -fobjc-arc

include $(THEOS)/makefiles/tweak.mk
