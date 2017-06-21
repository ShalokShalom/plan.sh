pkg_origin=cosmos

pkg_name=gamin
pkg_version=0.1.10
pkg_description='File and directory monitoring system defined to be a subset of the FAM (File Alteration Monitor).'
pkg_upstream_url='http://www.gnome.org/~veillard/gamin'
pkg_license=('GPL2')
pkg_deps=('glib2' 'python2')
pkg_source=("https://people.gnome.org/~veillard/gamin/sources/${pkg_name}-${pkg_version}.tar.gz"
        'const.patch'
        'gam_server.patch')
pkg_shasum=('b4ec549e57da470c04edd5ec2876a028'
         'f679aeb48fe9dd376c8828cc9b6941ab'
         '4784359a3206bfa3c0dce1c23468f87f')

do_build() {
  patch -p1 -i ${CACHE_PATH}/gam_server.patch
  patch -p1 -i ${CACHE_PATH}/const.patch

  ./configure \
    --disable-debug \
    --disable-debug-api \
    --disable-static \
    --libexecdir=/usr/lib/gamin \
    --prefix=/usr \
    --with-threads
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
