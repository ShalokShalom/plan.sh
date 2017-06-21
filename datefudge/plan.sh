pkg_origin=cosmos

pkg_name=datefudge
pkg_version=1.21
pkg_description="A program (and preload library) to fake system date"
pkg_upstream_url="http://packages.qa.debian.org/d/datefudge.html"
pkg_license=('GPL2')
pkg_deps=('sh')
pkg_source=("http://ftp.de.debian.org/debian/pool/main/d/datefudge/${pkg_name}_${pkg_version}.tar.xz")
pkg_shasum=('00198cdf241d629b5293cea4e06a4eaf')

do_build() {
  cd $pkg_name-$pkg_version

  make
}

do_check() {
  cd $pkg_name-$pkg_version

  make test
}

do_package() {
  cd $pkg_name-$pkg_version

  make DESTDIR=$pkg_prefix/ install
}
