pkg_origin=cosmos

pkg_name=bootchart
pkg_version=1.20
pkg_description="Tool that collects and graphs the CPU and disk load of the system as it works"
pkg_upstream_url="https://github.com/sofar/bootchart"
pkg_license=('GPL2')
pkg_deps=('glibc')
pkg_source=("http://foo-projects.org/~sofar/${pkg_name}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('071c67856a2b16e1a9e93a058de3eb65')

do_build() {

  ./configure --prefix=/usr --sbindir=/usr/bin

   make
}

do_package() {

  make DESTDIR=${pkg_prefix} install
}
