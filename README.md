<div align="center">

# Teeworlds AppImage 🐧

[![CI Build Status](https://github.com/Nemo-010/teeworlds-AppImage/actions/workflows/appimage.yml/badge.svg)](https://github.com/Nemo-010/teeworlds-AppImage/releases/latest)
[![Latest Stable Release](https://img.shields.io/github/v/release/Nemo-010/teeworlds-AppImage)](https://github.com/Nemo-010/teeworlds-AppImage/releases/latest)

| Latest Stable Release | Upstream URL |
| :---: | :---: |
| [Click here](https://github.com/Nemo-010/teeworlds-AppImage/releases/latest) | [Click here](https://github.com/teeworlds/teeworlds) |

</div>

---

Unofficial AppImage of [Teeworlds](https://github.com/teeworlds/teeworlds), the
fast-paced 2D multiplayer shooter, built from source with CMake.

AppImage made using [quick-sharun](https://github.com/pkgforge-dev/Anylinux-AppImages/blob/main/useful-tools/quick-sharun.sh), which makes it extremely easy to turn any binary into a portable package reliably without using containers or similar tricks.

**This AppImage bundles everything and it should work on any Linux distro, including old and musl-based ones.**

This AppImage doesn't require FUSE to run at all, thanks to the [uruntime](https://github.com/VHSgunzo/uruntime).

This AppImage is also supplied with a self-updater by default, so any updates to this application won't be missed, you will be prompted for permission to check for updates and if agreed you will then be notified when a new update is available.

Self-updater is disabled by default if AppImage managers like [am](https://github.com/ivan-hc/AM), [soar](https://github.com/pkgforge/soar) or [dbin](https://github.com/xplshn/dbin) exist, which manage AppImage updates.

## Building

The client and the dedicated server (`teeworlds_srv`) are both included in the
AppImage, and both are compiled from the latest upstream release tag. **Do not
build this anywhere except Arch Linux** — deploying this on any other
distribution is a very bad idea. The application must be installed to `/usr`
before `quick-sharun` deploys it, which `get-dependencies.sh` does with
`cmake --install`.

The game data (`/usr/share/teeworlds/data`) is copied to `$APPDIR/bin/data`,
because Teeworlds looks for its resources next to the path it was started as.
`teeworlds` then reports it as `$DATADIR`.

## Notes

The `0.7.5` release needs two small build fixes, both handled in
`get-dependencies.sh`: its submodules are declared with the retired `git://`
protocol (fetched over https instead), and it declares
`cmake_minimum_required(VERSION 2.8)`, which CMake 4 refuses to configure
without `-DCMAKE_POLICY_VERSION_MINIMUM=3.5`.

The icon is the 256x256 PNG frame from upstream's
`other/icons/teeworlds.ico`, the same source Arch's `teeworlds` package uses.