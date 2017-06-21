pkg_origin=cosmos

pkg_name=alsa-oss
pkg_version=1.0.28
pkg_description="OSS compatibility library"
pkg_license=('GPL')
pkg_upstream_url="https://www.alsa-project.org"
pkg_deps=('alsa-lib')
pkg_source=("ftp://ftp.alsa-project.org/pub/oss-lib/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('91f57e8cee1ad4cc956caa8b62ac5d43')

do_build() {
  
  ./configure --prefix=/usr
  make
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install
}

