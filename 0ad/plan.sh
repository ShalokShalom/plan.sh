pkg_origin=
pkg_name=0ad
pkg_version=a21
_pkg_version=0.0.21-alpha
pkg_description="Cross-platform, 3D and historically-based real-time strategy game"
pkg_upstream_url="http://play0ad.com/"
pkg_license=('GPL2' 'CCPL')
pkg_deps=('binutils' 'boost-libs' 'curl' 'enet>=1.3' 'libogg' 'libpng' 'libvorbis' 'libxml2'
         'openal' 'sdl2' 'zlib' 'libgl' '0ad-data' 'glu' 'gamin' 'libxcursor' 'mesa'
         'libjpeg' 'libtiff' 'openexr' 'gloox')
pkg_build_deps=('boost' 'cmake' 'zip' 'python2')
pkg_source=("http://releases.wildfiregames.com/${pkg_name}-${_pkg_version}-unix-build.tar.xz")
pkg_shasum=('095eade8c9b3deaf25d0d7fa423ff860')

do_build() {
  cd ${pkg_name}-${_pkg_version}/build/workspaces

  unset CPPFLAGS 

  ./update-workspaces.sh \
      --without-miniupnpc \
      --bindir=/usr/bin \
      --libdir=/usr/lib/0ad \
      --disable-atlas \
      --datadir=/usr/share/${pkg_name}/data

  cd gcc

  make 
}

do_package() {
  install -d ${pkg_prefix}/usr/{bin,lib/0ad,share/${pkg_name}/data}

  install -Dm755 ${CACHE_PATH}/${pkg_name}-${_pkg_version}/binaries/system/pyrogenesis ${pkg_prefix}/usr/bin
  install -Dm755 ${CACHE_PATH}/${pkg_name}-${_pkg_version}/binaries/system/*.so* ${pkg_prefix}/usr/lib/0ad
  
  cp -r ${CACHE_PATH}/${pkg_name}-${_pkg_version}/binaries/data/l10n/ ${pkg_prefix}/usr/share/${pkg_name}/data/

  install -Dm755 ${CACHE_PATH}/${pkg_name}-${_pkg_version}/build/resources/${pkg_name}.sh ${pkg_prefix}/usr/bin/${pkg_name}
  install -Dm644 ${CACHE_PATH}/$pkg_name-$_pkg_version/build/resources/${pkg_name}.desktop ${pkg_prefix}/usr/share/applications/${pkg_name}.desktop
  install -Dm644 ${CACHE_PATH}/$pkg_name-$_pkg_version/build/resources/${pkg_name}.png ${pkg_prefix}/usr/share/pixmaps/${pkg_name}.png
}
