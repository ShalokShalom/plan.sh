pkg_origin=

pkg_name=megaglest
pkg_version=3.13.0
pkg_description="Entertaining free (freeware and free software) and open source cross-platform 3D real-time strategy (RTS) game"
pkg_upstream_url="https://github.com/MegaGlest/megaglest-source"
pkg_license=('GPL3')
pkg_deps=('curl' 'megaglest-data' 'xerces-c' 'sdl2' 'libvorbis' 'openal' 'libgl' 'lua' 'icu' 'ftgl' 'glew'
         'miniupnpc' 'glu' 'libx11' 'vlc')
pkg_build_deps=('ftjam' 'cmake' 'git')
#pkg_source=("https://github.com/basxto/megaglest-source/tarball/qt4/megaglest-source-${pkg_version}.tar.gz")
pkg_source=("https://github.com/MegaGlest/megaglest-source/archive/${pkg_version}.tar.gz"
        "https://github.com/MegaGlest/megaglest-source/commit/a85d12aed1983eb69d630b431b81ae656d83b3ac.patch")
pkg_shasum=('e36337255f06b3769c1b098f967b8547'
         '1916ff2096f2b3e39c1ff39b33c55a26')

do_build() {
  cd megaglest-source-${pkg_version}
  # miniupnpc 2.0 needed patch
  #patch -p1 -i $CACHE_PATH/a85d12aed1983eb69d630b431b81ae656d83b3ac.patch

  mkdir build 
  cd build

  cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_FLAGS="-lX11" \
    -DWANT_GIT_STAMP=0 \
    -DBUILD_MEGAGLEST_MAP_EDITOR=Off \
    -DBUILD_MEGAGLEST_MODEL_IMPORT_EXPORT_TOOLS=Off \
    -DBUILD_MEGAGLEST_MODEL_VIEWER=Off
    
  make VERBOSE=1
}

do_package() {
  cd megaglest-source-${pkg_version}/build

  make DESTDIR="$pkg_prefix" install
}
