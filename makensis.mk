# Copyright (c) 2002-2015, Ross Smith II. MIT licensed.

APP_FILES+=license.txt

APP_NSI:=$(APP).nsi

NSIS_FILES+=version.txt
NSIS_FILES+=license.txt
NSIS_FILES+=$(wildcard *.nsh)
NSIS_FILES+=$(wildcard ../nshlib/*.nsh)

#######################################################################

ifndef MAKENSIS
	MAKENSIS:=$(shell which makensis 2>/dev/null)
endif

ifndef MAKENSIS
	NSIS_DIR:=$(shell cygpath -m -s "$(PROGRAMFILES)/NSIS" 2>/dev/null)
	ifneq ($(wildcard $(NSIS_DIR)/makensis.exe),)
		MAKENSIS:=$(NSIS_DIR)/makensis.exe
	endif
endif

#######################################################################

$(RELEASE_APP_EXE):	$(APP_NSI) $(NSIS_FILES)
	test -d $(dir $@) || mkdir -p $(dir $@)
	$(MAKENSIS) /V4 /O$(APP).log /DPRODUCT_VERSION=$(VER) /DPRODUCT_OUTFILE=$@ $(MAKENSIS_OPTS) $<
	chmod +x $@

.PHONY: all
all:	$(RELEASE_APP_EXE)

#######################################################################

.PHONY: clean
clean:
	-rm -f \
		$(RELEASE_APP_EXE) \
		$(CLEAN_FILES) \
		$(SIGNED_FILES) \
		$(UPXED_FILES)
