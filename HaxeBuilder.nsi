; Script generated by the HM NIS Edit Script Wizard.

; HM NIS Edit Wizard helper defines
!define PRODUCT_NAME "HaxeBuilder"
!define PRODUCT_VERSION "1.1.0"
!define PRODUCT_PUBLISHER "AS3Boyan"
!define PRODUCT_WEB_SITE "http://haxebuilder.blogspot.com/"
!define PRODUCT_DIR_REGKEY "Software\Microsoft\Windows\CurrentVersion\App Paths\HaxeBuilder.exe"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor lzma

; MUI 1.67 compatible ------
!include "MUI.nsh"
!include "EnvVarUpdate.nsh"

; MUI Settings
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; Welcome page
!insertmacro MUI_PAGE_WELCOME
; License page
!insertmacro MUI_PAGE_LICENSE "LICENSE"
; Directory page
!insertmacro MUI_PAGE_DIRECTORY
; Instfiles page
!insertmacro MUI_PAGE_INSTFILES
; Finish page
; !define MUI_FINISHPAGE_RUN "$INSTDIR\HaxeBuilder.exe"
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages
!insertmacro MUI_UNPAGE_INSTFILES

; Language files
!insertmacro MUI_LANGUAGE "English"

; Reserve files
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS

; MUI end ------

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "HaxeBuilder.exe"
InstallDir "$PROGRAMFILES\HaxeBuilder"
InstallDirRegKey HKLM "${PRODUCT_DIR_REGKEY}" ""
ShowInstDetails show
ShowUnInstDetails show

Section "MainSection" SEC01
  SetOutPath "$INSTDIR"
  SetOverwrite try
  File "bin\expressInstall.swf"
  File "bin\HaxeBuilder.exe"
  CreateDirectory "$SMPROGRAMS\HaxeBuilder"
  ;CreateShortCut "$SMPROGRAMS\HaxeBuilder\HaxeBuilder.lnk" "$INSTDIR\HaxeBuilder.exe"
  ;CreateShortCut "$DESKTOP\HaxeBuilder.lnk" "$INSTDIR\HaxeBuilder.exe"
  File "bin\index.html"
  SetOutPath "$INSTDIR\js"
  File "bin\js\swfobject.js"
  SetOutPath "$INSTDIR"
  File "bin\WebSocketTest.js"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateShortCut "$SMPROGRAMS\HaxeBuilder\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\HaxeBuilder\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
   ${EnvVarUpdate} $0 "PATH" "P" "HKCU" "$INSTDIR"

  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr HKLM "${PRODUCT_DIR_REGKEY}" "" "$INSTDIR\HaxeBuilder.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayIcon" "$INSTDIR\HaxeBuilder.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd


Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) was successfully removed from your computer."
FunctionEnd

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "Are you sure you want to completely remove $(^Name) and all of its components?" IDYES +2
  Abort
FunctionEnd

Section Uninstall
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\WebSocketTest.js"
  Delete "$INSTDIR\js\swfobject.js"
  Delete "$INSTDIR\index.html"
  Delete "$INSTDIR\HaxeBuilder.exe"
  Delete "$INSTDIR\expressInstall.swf"

  Delete "$SMPROGRAMS\HaxeBuilder\Uninstall.lnk"
  Delete "$SMPROGRAMS\HaxeBuilder\Website.lnk"
  Delete "$DESKTOP\HaxeBuilder.lnk"
  Delete "$SMPROGRAMS\HaxeBuilder\HaxeBuilder.lnk"

  RMDir "$SMPROGRAMS\HaxeBuilder"
  RMDir "$INSTDIR\js"
  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  DeleteRegKey HKLM "${PRODUCT_DIR_REGKEY}"
  
  ${un.EnvVarUpdate} $0 "PATH" "R" "HKLM" "$INSTDIR"
  
  SetAutoClose true
SectionEnd