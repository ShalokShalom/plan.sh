pkg_origin=

pkg_name=ksuperkey
pkg_version=0.4
pkg_description="Allows you to open the application launcher in KDE Plasma Desktop using the Super key, also known as Windows key"
pkg_upstream_url="https://github.com/hanschen/ksuperkey/"
pkg_license=('GPL')
pkg_deps=('libx11' 'libxtst')
pkg_build_deps=('pkg-config')
pkg_source=("https://github.com/hanschen/ksuperkey/archive/v0.4.tar.gz")
pkg_shasum=('2dd4539de4366e8aa185d5bf375e203b')

do_build() {
  cd ${pkg_name}-${pkg_version}

  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}

  make DESTDIR=${pkg_prefix} install
}
