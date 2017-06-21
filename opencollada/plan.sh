pkg_origin=

pkg_name=opencollada
pkg_version=20140302
#_commit=9665d16
pkg_description="Stream based reader and writer library for COLLADA files"
pkg_upstream_url="https://github.com/KhronosGroup/OpenCOLLADA"
pkg_license=('GPL')
pkg_deps=('libxml2' 'pcre')
pkg_build_deps=('ruby' 'cmake' 'git')
pkg_source=('git://github.com/KhronosGroup/OpenCOLLADA.git'
        'opencollada.conf')
pkg_shasum=('SKIP'
         '5f7e9d79ab86756648b648ee5ed6ce1d')

do_build() {
  cd "$CACHE_PATH"/OpenCOLLADA

  mkdir build
  cd build

  cmake .. \
    -DCMAKE_INSTALL_PREFIX=/usr -DUSE_SHARED=ON 
  make
}

do_package() {
  cd "$CACHE_PATH"/OpenCOLLADA/build

  make DESTDIR=$pkg_prefix install

  install -Dm644 $CACHE_PATH/opencollada.conf $pkg_prefix/etc/ld.so.conf.d/opencollada.conf
}

