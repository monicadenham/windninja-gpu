# This file will be configured to contain variables for CPack. These variables
# should be set in the CMake list file of the project before CPack module is
# included. The list of available CPACK_xxx variables and their associated
# documentation may be obtained using
#  cpack --help-variable-list
#
# Some variables are common to all generators (e.g. CPACK_PACKAGE_NAME)
# and some are specific to a generator
# (e.g. CPACK_NSIS_EXTRA_INSTALL_COMMANDS). The generator specific variables
# usually begin with CPACK_<GENNAME>_xxxx.


set(CPACK_BINARY_DEB "OFF")
set(CPACK_BINARY_FREEBSD "OFF")
set(CPACK_BINARY_IFW "OFF")
set(CPACK_BINARY_NSIS "OFF")
set(CPACK_BINARY_RPM "OFF")
set(CPACK_BINARY_STGZ "ON")
set(CPACK_BINARY_TBZ2 "OFF")
set(CPACK_BINARY_TGZ "ON")
set(CPACK_BINARY_TXZ "OFF")
set(CPACK_BINARY_TZ "ON")
set(CPACK_BUILD_SOURCE_DIRS "/home/mdenham/WindNinjaParalelo/windninja;/home/mdenham/WindNinjaParalelo/windninja/build")
set(CPACK_CMAKE_GENERATOR "Unix Makefiles")
set(CPACK_COMPONENTS_ALL "Unspecified;apps;includes;libs")
set(CPACK_COMPONENT_APPS_REQUIRED "TRUE")
set(CPACK_COMPONENT_INCLUDES_DISABLED "TRUE")
set(CPACK_COMPONENT_INCLUDES_HIDDEN "TRUE")
set(CPACK_COMPONENT_LIBS_DISABLED "TRUE")
set(CPACK_COMPONENT_LIBS_HIDDEN "TRUE")
set(CPACK_COMPONENT_UNSPECIFIED_HIDDEN "TRUE")
set(CPACK_COMPONENT_UNSPECIFIED_REQUIRED "TRUE")
set(CPACK_CREATE_DESKTOP_LINKS "WindNinja")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_FILE "/usr/share/cmake-3.22/Templates/CPack.GenericDescription.txt")
set(CPACK_DEFAULT_PACKAGE_DESCRIPTION_SUMMARY "WindNinja built using CMake")
set(CPACK_GENERATOR "TBZ2;TGZ;TXZ;TZ")
set(CPACK_IGNORE_FILES "/CVS/;/\\.svn/;/\\.bzr/;/\\.hg/;/\\.git/;\\.swp\$;\\.#;/#")
set(CPACK_INSTALLED_DIRECTORIES "/home/mdenham/WindNinjaParalelo/windninja;/")
set(CPACK_INSTALL_CMAKE_PROJECTS "")
set(CPACK_INSTALL_PREFIX "/usr/local")
set(CPACK_MODULE_PATH "/home/mdenham/WindNinjaParalelo/windninja/cmake/Modules/")
set(CPACK_NSIS_CREATE_ICONS_EXTRA "
CreateDirectory \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Tutorials\"
CreateDirectory \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Documents\"
CreateShortCut \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Tutorials\\Tutorial 1.lnk\"  \"$INSTDIR\\share\\windninja\\doc\\tutorials\\WindNinja_Tutorial1.pdf\"
CreateShortCut \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Tutorials\\Tutorial 2.lnk\"  \"$INSTDIR\\share\\windninja\\doc\\tutorials\\WindNinja_Tutorial2.pdf\"
CreateShortCut \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Tutorials\\Tutorial 3.lnk\"  \"$INSTDIR\\share\\windninja\\doc\\tutorials\\WindNinja_Tutorial3.pdf\"
CreateShortCut \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Tutorials\\Tutorial 4.lnk\"  \"$INSTDIR\\share\\windninja\\doc\\tutorials\\WindNinja_Tutorial4.pdf\"
CreateShortCut \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Documents\\CLI Instructions.lnk\"  \"$INSTDIR\\share\\windninja\\doc\\CLI_instructions.pdf\"
CreateShortCut \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Documents\\ArcMap Instructions.lnk\"  \"$INSTDIR\\share\\windninja\\doc\\Displaying_wind_vectors_in_ArcMap.pdf\"
CreateShortCut \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Documents\\DEM Download Instructions.lnk\" \"$INSTDIR\\share\\windninja\\doc\\download_elevation_file.pdf\"
CreateShortCut \"$SMPROGRAMS\\$STARTMENU_FOLDER\\Example Files.lnk\" \"$INSTDIR\\etc\\windninja\\example-files\" ")
set(CPACK_NSIS_DELETE_ICONS_EXTRA "
Delete \"$SMPROGRAMS\\$MUI_TEMP\\Tutorials\\Tutorial 1.lnk\"
Delete \"$SMPROGRAMS\\$MUI_TEMP\\Tutorials\\Tutorial 2.lnk\"
Delete \"$SMPROGRAMS\\$MUI_TEMP\\Tutorials\\Tutorial 3.lnk\"
Delete \"$SMPROGRAMS\\$MUI_TEMP\\Tutorials\\Tutorial 4.lnk\"
Delete \"$SMPROGRAMS\\$MUI_TEMP\\Documents\\CLI Instructions.lnk\"
Delete \"$SMPROGRAMS\\$MUI_TEMP\\Documents\\ArcMap Instructions.lnk\"
Delete \"$SMPROGRAMS\\$MUI_TEMP\\Documents\\DEM Download Instructions.lnk\"
Delete \"$SMPROGRAMS\\$MUI_TEMP\\Example Files.lnk\"
RMDir \"$SMPROGRAMS\\$MUI_TEMP\\Tutorials\"
RMDir \"$SMPROGRAMS\\$MUI_TEMP\\Documents\" ")
set(CPACK_NSIS_DISPLAY_NAME "WindNinja\\WindNinja-3.12.0")
set(CPACK_NSIS_DISPLAY_NAME_SET "TRUE")
set(CPACK_NSIS_INSTALLED_ICON_NAME "/home/mdenham/WindNinjaParalelo/windninja/images/icons/wn-desktop.ico")
set(CPACK_NSIS_INSTALLER_ICON_CODE "")
set(CPACK_NSIS_INSTALLER_MUI_ICON_CODE "")
set(CPACK_NSIS_INSTALL_ROOT "C:")
set(CPACK_NSIS_MODifY_PATH "WindNinja")
set(CPACK_NSIS_PACKAGE_NAME "WindNinja-3.12.0")
set(CPACK_NSIS_UNINSTALL_NAME "Uninstall")
set(CPACK_OUTPUT_CONFIG_FILE "/home/mdenham/WindNinjaParalelo/windninja/build/CPackConfig.cmake")
set(CPACK_PACKAGE_DEFAULT_LOCATION "/")
set(CPACK_PACKAGE_DESCRIPTION_FILE "/usr/share/cmake-3.22/Templates/CPack.GenericDescription.txt")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY "WindNinja built using CMake")
set(CPACK_PACKAGE_EXECUTABLES "WindNinja;WindNinja-3.12.0")
set(CPACK_PACKAGE_FILE_NAME "WindNinja-3.12.0-Source")
set(CPACK_PACKAGE_INSTALL_DIRECTORY "WindNinja\\WindNinja-3.12.0")
set(CPACK_PACKAGE_INSTALL_REGISTRY_KEY "WindNinja\\WindNinja-3.12.0")
set(CPACK_PACKAGE_NAME "WindNinja")
set(CPACK_PACKAGE_RELOCATABLE "true")
set(CPACK_PACKAGE_VENDOR "Humanity")
set(CPACK_PACKAGE_VERSION "3.12.0")
set(CPACK_PACKAGE_VERSION_MAJOR "0")
set(CPACK_PACKAGE_VERSION_MINOR "1")
set(CPACK_PACKAGE_VERSION_PATCH "1")
set(CPACK_RESOURCE_FILE_LICENSE "/home/mdenham/WindNinjaParalelo/windninja/LICENSE")
set(CPACK_RESOURCE_FILE_README "/usr/share/cmake-3.22/Templates/CPack.GenericDescription.txt")
set(CPACK_RESOURCE_FILE_WELCOME "/usr/share/cmake-3.22/Templates/CPack.GenericWelcome.txt")
set(CPACK_RPM_PACKAGE_SOURCES "ON")
set(CPACK_SET_DESTDIR "OFF")
set(CPACK_SOURCE_GENERATOR "TBZ2;TGZ;TXZ;TZ")
set(CPACK_SOURCE_IGNORE_FILES "/CVS/;/\\.svn/;/\\.bzr/;/\\.hg/;/\\.git/;\\.swp\$;\\.#;/#")
set(CPACK_SOURCE_INSTALLED_DIRECTORIES "/home/mdenham/WindNinjaParalelo/windninja;/")
set(CPACK_SOURCE_OUTPUT_CONFIG_FILE "/home/mdenham/WindNinjaParalelo/windninja/build/CPackSourceConfig.cmake")
set(CPACK_SOURCE_PACKAGE_FILE_NAME "WindNinja-3.12.0-Source")
set(CPACK_SOURCE_RPM "OFF")
set(CPACK_SOURCE_TBZ2 "ON")
set(CPACK_SOURCE_TGZ "ON")
set(CPACK_SOURCE_TOPLEVEL_TAG "Linux-Source")
set(CPACK_SOURCE_TXZ "ON")
set(CPACK_SOURCE_TZ "ON")
set(CPACK_SOURCE_ZIP "OFF")
set(CPACK_STRIP_FILES "")
set(CPACK_SYSTEM_NAME "Linux")
set(CPACK_THREADS "1")
set(CPACK_TOPLEVEL_TAG "Linux-Source")
set(CPACK_VERSION_MAJOR "3")
set(CPACK_VERSION_MINOR "12")
set(CPACK_VERSION_PATCH "0")
set(CPACK_WIX_SIZEOF_VOID_P "8")

if(NOT CPACK_PROPERTIES_FILE)
  set(CPACK_PROPERTIES_FILE "/home/mdenham/WindNinjaParalelo/windninja/build/CPackProperties.cmake")
endif()

if(EXISTS ${CPACK_PROPERTIES_FILE})
  include(${CPACK_PROPERTIES_FILE})
endif()
