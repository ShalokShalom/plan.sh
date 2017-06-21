pkg_origin=cosmos

pkg_name=eventlog
pkg_version=0.2.12
_pkg_version=0.2
pkg_description="A new API to format and send structured log messages"
pkg_upstream_url="http://www.balabit.com/support/community/products/"
pkg_license=('BSD')
pkg_deps=('glibc')
pkg_source=("http://www.balabit.com/downloads/files/eventlog/${_pkg_version}/eventlog_${pkg_version}.tar.gz")
pkg_shasum=('3d6ebda8a161d36cb40d09328f78786b')

do_build() {
  cd ${pkg_name}-${pkg_version}
  
  ./configure --prefix=/usr \
              --sysconfdir=/etc \
              --localstatedir=/var
  make
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  
  make DESTDIR=${pkg_prefix} install 
  install -D -m644 COPYING ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE
}
