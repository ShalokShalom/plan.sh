pkg_origin=cosmos

pkg_name=python3
pkg_version=3.6.1
_pybasever=3.6
pkg_description="Next generation of the python high-level scripting language"
pkg_license=('custom')
pkg_upstream_url="https://www.python.org"
pkg_deps=('expat' 'bzip2' 'gdbm' 'openssl' 'libffi' 'zlib')
pkg_build_deps=('tk' 'sqlite' 'valgrind' 'bluez' 'libgl' 'llvm') # libgl for tests
optpkg_deps=('tk: for tkinter')
pkg_source=("https://www.python.org/ftp/python/${pkg_version}/Python-${pkg_version}.tar.xz")
pkg_shasum=('692b4fc3a2ba0d54d1495d4ead5b0b5c')  

do_build() {

  sed -i -e "s|^#.* /usr/local/bin/python|#!/usr/bin/python|" Lib/cgi.py

  # Use the system copy   
  rm -r Modules/expat
  rm -r Modules/zlib
  rm -r Modules/_ctypes/{darwin,libffi}*

  ./configure --prefix=/usr \
              --enable-shared \
              --with-threads \
              --with-computed-gotos \
              --enable-ipv6 \
              --with-valgrind \
              --with-system-expat \
              --with-dbmliborder=gdbm:ndbm \
              --with-system-ffi \
              --without-ensurepip

  make
}

do_check() {

  LD_LIBRARY_PATH=${CACHE_PATH}/Python-${pkg_version}:${LD_LIBRARY_PATH} \
     ${CACHE_PATH}/Python-${pkg_version}/python -m test.regrtest -x test_posixpath test_logging test_site test_urllib2_localnet test_pyexpat
}

do_package() {
  make DESTDIR=${CACHE_PATH} install maninstall

  # Conflicts with python2 
  rm ${CACHE_PATH}/usr/bin/2to3

  ln -sf ../../libpython${_pybasever}mu.so \
    ${CACHE_PATH}/usr/lib/python${_pybasever}/config-${_pybasever}m-x86_64-linux-gnu/libpython${_pybasever}m.so

  # Clean-up reference to build directory
  sed -i "s|${CACHE_PATH}/Python-${pkg_version}:||" ${CACHE_PATH}/usr/lib/python${_pybasever}/config-${_pybasever}m-x86_64-linux-gnu/Makefile

  install -Dm644 LICENSE ${CACHE_PATH}/usr/share/licenses/${pkg_name}/LICENSE
}
