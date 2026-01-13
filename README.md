# libass-cmake

Build libass for Android.

## library version
* [unibreak](https://github.com/adah1972/libunibreak) [v6.1](https://github.com/adah1972/libunibreak/releases/tag/libunibreak_6_1)
* [harfbuzz](https://github.com/harfbuzz/harfbuzz) [v11.3.3](https://github.com/harfbuzz/harfbuzz/releases/tag/11.2.1)
* [fribidi](https://github.com/fribidi/fribidi) [v1.0.16](https://github.com/fribidi/fribidi/releases/tag/v1.0.16)
* [freetype](https://gitlab.freedesktop.org/freetype/freetype) [v2.13.3](https://gitlab.freedesktop.org/freetype/freetype/-/tags/VER-2-13-3)
* [expat](https://github.com/libexpat/libexpat) [2.7.1](https://github.com/libexpat/libexpat/releases/tag/R_2_7_1)
* [fontconfig](https://gitlab.freedesktop.org/fontconfig/fontconfig) [master with daa175d2](https://gitlab.freedesktop.org/fontconfig/fontconfig/-/commit/daa175d234b8a362eedd4c18c33537cc2d19cd98)
* [ass](https://github.com/libass/libass) [v0.17.4](https://github.com/libass/libass/releases/tag/0.17.4)

## how to use

### clone and init
`git clone --recurse-submodules https://github.com/peerless2012/libass-cmake.git ./src/main/cpp`

### prepare
* make sure you have `libtool`
* make sure you hav `perl`
* install `autopoint`
* install `ninja-build`
* install androidNDK
### Run .sh
Run build_android.sh and merge_android_libs.sh
