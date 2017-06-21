pkg_origin=cosmos

pkg_name=lensfun
pkg_version=0.3.2
pkg_description="Database of photographic lenses and a library that allows advanced access to the database"
pkg_upstream_url="http://lensfun.sourceforge.net/"
pkg_license=('LGPL3')
pkg_deps=('glibc' 'glib2')
pkg_build_deps=('python3' 'libpng' 'cmake')
#pkg_source=("https://github.com/lensfun/lensfun/archive/v${pkg_version}.tar.gz")
pkg_source=("https://sourceforge.net/projects/lensfun/files/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz") 
pkg_shasum=('247e59a0812ec451f6cd0d20b3379cb5')

do_build() {
    
    cmake -DCMAKE_INSTALL_PREFIX=/usr \
          -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_INSTALL_LIBDIR=lib \
          -DBUILD_AUXFUN=ON
    make
}

do_package() {
    
    make DESTDIR=${pkg_prefix} install  
}
