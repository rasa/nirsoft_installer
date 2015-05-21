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

InstType "Top 10 - Windows 32-bit" # 1
InstType "Top 10 - Windows 64-bit" # 2
InstType "All - Windows 64-bit - All versions" # 3
InstType "All - Windows 32-bit - 8/7/Vista or newer" # 4
InstType "All - Windows 32-bit - 2008/2003/XP" # 5
InstType "All - Windows 2000/NT" # 6
InstType "All - Windows NT" # 7
InstType "All - Windows ME/98/95" # 8
InstType "All - Windows 95" # 9
InstType "Added in release 1.47 (32-bit)" # 10
InstType "Added in release 1.47 (64-bit)" # 11
InstType "Added in release ${PRODUCT_VERSION} (32-bit)" # 12
InstType "Added in release ${PRODUCT_VERSION} (64-bit)" # 13
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
