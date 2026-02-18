#!/bin/bash

echo "=============================================="
echo "WindNinja GPU - Dependency Installer"
echo "=============================================="
echo ""
echo "This script will install the required dependencies for building WindNinja with GPU support."
echo ""

sudo apt-get update

sudo apt-get install -y \
    cmake \
    build-essential \
    libboost-all-dev \
    libgdal-dev \
    libnetcdf-dev \
    libcurl4-openssl-dev \
    libshp-dev \
    pkg-config

echo ""
echo "=============================================="
echo "Dependencies installed!"
echo "=============================================="
echo ""
echo "Now run: ./build_gpu.sh"
