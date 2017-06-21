pkg_origin=cosmos

pkg_name=libgdiplus
pkg_version=4.2
pkg_description="Open Source Implementation of the GDI+ API"
pkg_license=('MPL' 'LGPL')
pkg_upstream_url="https://www.mono-project.com"
pkg_deps=('libtiff' 'cairo' 'giflib' 'glib2' 'libexif')
pkg_build_deps=('pkgconfig')
pkg_source=("https://download.mono-project.com/sources/libgdiplus/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('3e68075aa0911d5ebc2b3739e85af0ea')

do_build() {
  
  ./configure --prefix=/usr --with-cairo=system
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
