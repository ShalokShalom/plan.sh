pkg_origin=cosmos

pkg_name=libatasmart
pkg_version=0.19
pkg_description="ATA S.M.A.R.T. Reading and Parsing Library"
pkg_license=('LGPL')
pkg_deps=('systemd')
pkg_upstream_url="http://0pointer.de/blog/projects/being-smart.html"
pkg_source=("http://0pointer.de/public/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('53afe2b155c36f658e121fe6def33e77')

do_build() {
  
  ./configure --prefix=/usr \
    --sysconfdir=/etc \
    --localstatedir=/var \
    --disable-static
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}
