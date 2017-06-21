pkg_origin=cosmos

pkg_name=dmidecode
pkg_version=3.1
pkg_description="Desktop Management Interface table related utilities"
pkg_upstream_url="http://www.nongnu.org/dmidecode"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("https://download.savannah.nongnu.org/releases/dmidecode/${pkg_name}-${pkg_version}.tar.xz")
pkg_shasum=('679c2c015c515aa6ca5f229aee49c102')

do_build() {

  make prefix=/usr
}

do_package() {

  make prefix=/usr DESTDIR=${pkg_prefix} install
}
