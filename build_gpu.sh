#!/bin/bash

BUILD_DIR="build"
CUDA_SUPPORT=ON

echo "=============================================="
echo "WindNinja GPU Build Script"
echo "=============================================="

# Check for required dependencies
echo "Checking dependencies..."

MISSING_DEPS=""

# Check for cmake
if ! command -v cmake &> /dev/null; then
    MISSING_DEPS="$MISSING_DEPS cmake"
fi

# Check for boost
if [ ! -d "/usr/include/boost" ] && [ ! -f "/usr/lib/x86_64-linux-gnu/libboost_*.so" ]; then
    MISSING_DEPS="$MISSING_DEPS libboost-all-dev"
fi

# Check for GDAL
if ! pkg-config --exists gdal 2>/dev/null; then
    MISSING_DEPS="$MISSING_DEPS libgdal-dev"
fi

# Check for NetCDF
if ! pkg-config --exists netcdf 2>/dev/null; then
    MISSING_DEPS="$MISSING_DEPS libnetcdf-dev"
fi

# Check for CUDA
if ! command -v nvcc &> /dev/null; then
    echo "WARNING: CUDA not found, building without GPU support"
    CUDA_SUPPORT=OFF
fi

if [ ! -z "$MISSING_DEPS" ]; then
    echo ""
    echo "Missing dependencies detected:$MISSING_DEPS"
    echo ""
    echo "Please install them with:"
    echo "sudo apt-get install$MISSING_DEPS"
    echo ""
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

if [ ! -d "$BUILD_DIR" ]; then
    mkdir $BUILD_DIR
fi

cd $BUILD_DIR

echo ""
echo "Configuring with CUDA support: $CUDA_SUPPORT"
echo ""

cmake .. -DCUDA_SUPPORT=$CUDA_SUPPORT \
         -DCMAKE_BUILD_TYPE=Release \
         -DNINJA_CLI=ON \
         -DNINJA_GUI=OFF \
         -DBoost_USE_STATIC_LIBS=OFF \
         -DBoost_USE_MULTITHREADED=ON \
         -DBoost_NO_SYSTEM_PATHS=ON

if [ $? -ne 0 ]; then
    echo "Error: CMake configuration failed"
    echo ""
    echo "Common fixes:"
    echo "1. Install missing dependencies: sudo apt-get install libboost-all-dev libgdal-dev libnetcdf-dev libcurl4-openssl-dev"
    echo "2. If using conda, make sure environment is activated"
    exit 1
fi

echo ""
echo "Building..."
echo ""

make -j$(nproc)

if [ $? -ne 0 ]; then
    echo "Error: Build failed"
    exit 1
fi

echo ""
echo "=============================================="
echo "Build completed successfully!"
echo "=============================================="
