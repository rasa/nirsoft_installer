# Copyright (c) 2005-2015 Ross Smith II (http://smithii.com). MIT Licensed.

!define PRODUCT_NAME "nirsoft_installer"
!define PRODUCT_DIR "NirSoft"
#!define PRODUCT_VERSION "1.0"
!define PRODUCT_DESC "NirSoft™ Freeware Installer ${PRODUCT_VERSION}"
!define PRODUCT_TRADEMARKS "NirSoft™ is a trademark of Nir Softer (http://nirsoft.net)"

!addincludedir "../nsislib"
!addincludedir "nsislib"

!include "config.nsh"
!include "DumpLog.nsh"

!undef PRODUCT_EXE
!undef PRODUCT_FILE
!define NO_DESKTOP_ICONS
!define ADD_INSTDIR_TO_PATH

!define COPYDIR "$EXEDIR"
!define NOEXTRACTPATH
!define UNZIP_DIR "$INSTDIR"

InstType "Top 10 - Windows 32-bit"
InstType "Top 10 - Windows 64-bit"
InstType "All - Windows 64-bit - All versions"
InstType "All - Windows 32-bit - 8/7/Vista or newer"
InstType "All - Windows 32-bit - 2008/2003/XP"
InstType "All - Windows 2000/NT"
InstType "All - Windows NT"
InstType "All - Windows ME/98/95"
InstType "All - Windows 95"
InstType "Added in release ${PRODUCT_VERSION} (32-bit)"
InstType "Added in release ${PRODUCT_VERSION} (64-bit)"
InstType "None"

!include "common.nsh"

# !macro DumpLogMacro sectionin title url
# 	!undef _SECTION_NO
# 	!define _SECTION_NO ${SECTION_NO}
# 	!undef SECTION_NO
# 	!define /math SECTION_NO ${_SECTION_NO} + 1
#
# 	Section "${title}" Section${SECTION_NO}
# 		SectionIn ${sectionin}
#
# 		GetTempFileName $0
# 		Push $0
# 		Call DumpLog
# 	SectionEnd
#
# 	!insertmacro appendfile "Section${SECTION_NO}" "${url}"
# !macroend

Section "Nirsoft Command Line"
	SectionIn 1 2 3 4 5 6 7 8 9
	SetOutPath $INSTDIR
	CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\ Nirsoft Command Line.lnk" "$SYSDIR\cmd.exe"
SectionEnd

Section "Nirsoft Help Files"
	SectionIn 1 2 3 4 5 6 7 8 9
	SetOutPath $INSTDIR
	CreateShortCut "$SMPROGRAMS\$STARTMENU_FOLDER\ Nirsoft Help Files.lnk" "$INSTDIR"
SectionEnd

!include "nirsoft_installer.nsh"

# !insertmacro DumpLogMacro "2 3"	"DumpLog" "url"
