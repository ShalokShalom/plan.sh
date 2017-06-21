pkg_origin=cosmos

pkg_name=shared-mime-info
pkg_version=1.8
pkg_description="Freedesktop.org Shared MIME Info"
pkg_upstream_url="http://freedesktop.org/Software/shared-mime-info"
pkg_license=('GPL')
pkg_deps=('libxml2' 'glib2')
pkg_build_deps=('intltool' 'pkgconfig')
pkg_source=("http://freedesktop.org/~hadess/${pkg_name}-${pkg_version}.tar.xz"
        'update-mime-database.hook')
pkg_shasum=('f6dcadce764605552fc956563efa058c'
         'fc48155d8fb2147b8fc72597e79936b4')

do_build() {
  cd ${pkg_name}-${pkg_version}
  # stop pacman datasync after each package
  export ac_cv_func_fdatasync=no
  
  ./configure --prefix=/usr --disable-update-mimedb
  make
}

do_check() {
  cd ${pkg_name}-${pkg_version}
  
  make -k check
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 ../update-mime-database.hook ${pkg_prefix}/usr/share/libalpm/hooks/update-mime-database.hook
}
