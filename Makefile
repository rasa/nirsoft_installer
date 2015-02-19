# nirsoft_installer

VER?=$(shell cat version.txt)
NSI?=$(wildcard *.nsi)
APP?=$(shell basename *.nsi .nsi)
PREFIX?=$(APP)-$(VER)-win32
EXE?=$(PREFIX).exe
NSHS?=$(wildcard ../nshlib/*.nsh)
APP_ZIP?=$(PREFIX).zip
SRC_ZIP?=$(PREFIX)-src.zip
APP_FILES=$(EXE) $(wildcard license.txt *.md)
SRC_FILES=$(APP_FILES) $(NSHS) $(wildcard Makefile *.mak *.nsi *.nsh *.sh version.txt)

ZIP?=zip
ZIP_OPTS?=-9jquX

ifdef PROGRAMFILES
	NSIS_DIR:=$(shell cygpath -m -s "$(PROGRAMFILES)/NSIS" 2>/dev/null)
	ifneq ($(wildcard $(NSIS_DIR)/.*),)
		NSIS2_DIR:=$(shell cygpath -u "$(NSIS_DIR)" 2>/dev/null)
		ifneq ($(wildcard $(NSIS2_DIR)/.*),)
			PATH+=:$(NSIS2_DIR)
		endif
	endif
endif

all:	$(EXE)

$(EXE):	$(NSI) $(NSHS) version.txt
	makensis /V4 /O$(APP).log /DPRODUCT_VERSION=$(VER) /DPRODUCT_OUTFILE=$@ $<
	chmod a+x *.exe

$(APP_ZIP):	$(APP_FILES)
	-rm -f $(APP_ZIP)
	${ZIP} ${ZIP_OPTS} $@ $^

$(SRC_ZIP):	$(SRC_FILES)
	-rm -f $(SRC_ZIP)
	${ZIP} ${ZIP_OPTS} $@ $^

dist:	all $(APP_ZIP) $(SRC_ZIP)

run:	all
	cmd /c ${EXE}

run1:	all
	cmd /c ${EXE} /INSTYPE 1

run1s:	all
	cmd /c ${EXE} /INSTYPE 1 /S

clean:
	rm -f *.exe *.log

distclean:	clean
	rm -f $(APP_ZIP) $(SRC_ZIP)

realclean: clean

.PHONY:	all clean dist distclean realclean run run1 run1s
