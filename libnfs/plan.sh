pkg_origin=cosmos

pkg_name=libnfs
pkg_version=1.11.0
pkg_description="Client library for accessing NFS shares over a network."
pkg_upstream_url="https://github.com/sahlberg/libnfs"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("https://github.com/sahlberg/libnfs/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('863b9a7beafb02d93ee963ef84bc6e63')

do_build() {

  ./bootstrap
    ./configure --prefix=/usr
  make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
