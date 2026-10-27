#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm --needed \
	base-devel       \
	cmake            \
	curl             \
	freetype2        \
	git              \
	glu              \
	libglvnd         \
	openssl          \
	python           \
	sdl2             \
	strace           \
	wavpack          \
	xorg-server-xvfb \
	zlib

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building Teeworlds from source..."
echo "---------------------------------------------------------------"
git clone https://github.com/teeworlds/teeworlds ./teeworlds
cd ./teeworlds

if [ "${DEVEL_RELEASE-}" = 1 ]; then
	git rev-parse --short HEAD > ~/version
else
	git fetch --tags origin
	TAG=$(git tag --sort=-v:refname | grep -vi 'rc\|alpha\|beta' | head -1)
	git checkout "$TAG"
	echo "${TAG#v}" > ~/version
fi

# the 0.7.5 release declares its submodules with the retired git:// protocol,
# which github no longer serves, so fetch them over https instead
git config submodule.datasrc/languages.url https://github.com/teeworlds/teeworlds-translation.git
git config submodule.datasrc/maps.url https://github.com/teeworlds/teeworlds-maps.git
git submodule update --init --recursive

# the 0.7.5 release still says 'cmake_minimum_required(VERSION 2.8)',
# which cmake 4 refuses to configure without this
cmake -S . -B build                    \
	-DCMAKE_BUILD_TYPE=Release     \
	-DCMAKE_POLICY_VERSION_MINIMUM=3.5
cmake --build build -j"$(nproc)"
cmake --install build --prefix /usr