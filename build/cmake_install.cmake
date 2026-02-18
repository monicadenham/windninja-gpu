# Install script for directory: /home/mdenham/WindNinjaParalelo/windninja

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/mdenham/WindNinjaParalelo/windninja/build/src/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/home/mdenham/WindNinjaParalelo/windninja/build/autotest/cmake_install.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xappsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/etc/windninja/example-files" TYPE FILE FILES
    "/home/mdenham/WindNinjaParalelo/windninja/data/missoula_valley.tif"
    "/home/mdenham/WindNinjaParalelo/windninja/data/example_lcp.tif"
    "/home/mdenham/WindNinjaParalelo/windninja/data/cli_domainAverage.cfg"
    "/home/mdenham/WindNinjaParalelo/windninja/data/cli_domainAverage_diurnal.cfg"
    "/home/mdenham/WindNinjaParalelo/windninja/data/cli_pointInitialization_diurnal.cfg"
    "/home/mdenham/WindNinjaParalelo/windninja/data/cli_wxModelInitialization_diurnal.cfg"
    "/home/mdenham/WindNinjaParalelo/windninja/data/cli_momentumSolver_diurnal.cfg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xappsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/etc/windninja/example-files/WXSTATIONS-2018-06-25-1237-missoula_valley" TYPE FILE FILES
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-2018-06-25-1237-missoula_valley/missoula_valley_stations_4.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-2018-06-25-1237-missoula_valley/KMSO-2018-06-25_1237-0.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-2018-06-25-1237-missoula_valley/PNTM8-2018-06-25_1237-2.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-2018-06-25-1237-missoula_valley/TR266-2018-06-25_1237-3.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-2018-06-25-1237-missoula_valley/TS934-2018-06-25_1237-1.csv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xappsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/etc/windninja/example-files/WXSTATIONS-MDT-2018-06-20-2128-2018-06-21-2128-missoula_valley" TYPE FILE FILES
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-MDT-2018-06-20-2128-2018-06-21-2128-missoula_valley/missoula_valley_stations_4.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-MDT-2018-06-20-2128-2018-06-21-2128-missoula_valley/KMSO-MDT-2018-06-20_2128-2018-06-21_2128-0.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-MDT-2018-06-20-2128-2018-06-21-2128-missoula_valley/PNTM8-MDT-2018-06-20_2128-2018-06-21_2128-2.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-MDT-2018-06-20-2128-2018-06-21-2128-missoula_valley/TR266-MDT-2018-06-20_2128-2018-06-21_2128-3.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/WXSTATIONS-MDT-2018-06-20-2128-2018-06-21-2128-missoula_valley/TS934-MDT-2018-06-20_2128-2018-06-21_2128-1.csv"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xappsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/windninja" TYPE FILE FILES
    "/home/mdenham/WindNinjaParalelo/windninja/data/date_time_zonespec.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/config_options.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/tz_world.zip"
    "/home/mdenham/WindNinjaParalelo/windninja/data/landfire.zip"
    "/home/mdenham/WindNinjaParalelo/windninja/data/map.html"
    "/home/mdenham/WindNinjaParalelo/windninja/data/qt_certs_bundle.pem"
    "/home/mdenham/WindNinjaParalelo/windninja/data/thredds.csv"
    "/home/mdenham/WindNinjaParalelo/windninja/data/surface_data.zip"
    "/home/mdenham/WindNinjaParalelo/windninja/data/srtm_region.geojson"
    "/home/mdenham/WindNinjaParalelo/windninja/data/us_srtm_region.dbf"
    "/home/mdenham/WindNinjaParalelo/windninja/data/us_srtm_region.prj"
    "/home/mdenham/WindNinjaParalelo/windninja/data/us_srtm_region.shp"
    "/home/mdenham/WindNinjaParalelo/windninja/data/us_srtm_region.shx"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/windninja" TYPE DIRECTORY FILES "/home/mdenham/WindNinjaParalelo/windninja/data/leaflet")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xappsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/windninja/doc" TYPE FILE FILES
    "/home/mdenham/WindNinjaParalelo/windninja/doc/CLI_instructions.pdf"
    "/home/mdenham/WindNinjaParalelo/windninja/doc/displaying_wind_vectors_in_ArcGIS_Pro.pdf"
    "/home/mdenham/WindNinjaParalelo/windninja/doc/download_elevation_file.pdf"
    "/home/mdenham/WindNinjaParalelo/windninja/doc/fetch_dem_instructions.pdf"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xappsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/windninja/doc/tutorials" TYPE FILE FILES
    "/home/mdenham/WindNinjaParalelo/windninja/doc/tutorials/WindNinja_tutorial1.pdf"
    "/home/mdenham/WindNinjaParalelo/windninja/doc/tutorials/WindNinja_tutorial2.pdf"
    "/home/mdenham/WindNinjaParalelo/windninja/doc/tutorials/WindNinja_tutorial3.pdf"
    "/home/mdenham/WindNinjaParalelo/windninja/doc/tutorials/WindNinja_tutorial4.pdf"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/windninja" TYPE DIRECTORY FILES "/home/mdenham/WindNinjaParalelo/windninja/data/ninjafoam")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/windninja" TYPE FILE FILES "/home/mdenham/WindNinjaParalelo/windninja/data/wn-splash.png")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/windninja" TYPE FILE FILES "/home/mdenham/WindNinjaParalelo/windninja/data/relief.xml")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/windninja" TYPE FILE FILES "/home/mdenham/WindNinjaParalelo/windninja/data/topofire_logo.png")
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/mdenham/WindNinjaParalelo/windninja/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
