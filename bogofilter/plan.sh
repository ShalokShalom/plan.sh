pkg_origin=cosmos

pkg_name=bogofilter
pkg_version=1.2.3
pkg_description="A fast Bayesian spam filtering tool"
pkg_license=('GPL3')
pkg_upstream_url="http://bogofilter.sourceforge.net"
pkg_deps=('db' 'perl' 'gsl')
backup=(etc/bogofilter/bogofilter.cf)
pkg_source=("http://sourceforge.net/projects/${pkg_name}/files/${pkg_name}-current/${pkg_name}-${pkg_version}/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('c3ed7f483b83abcbf6d8c797084bd06e')

do_build() {
  
  ./configure --prefix=/usr \
              --sysconfdir=/etc/bogofilter  \
              --localstatedir=/var \
              --enable-transactions
  make
}

do_package() {
  make DESTDIR=${pkg_prefix} install

  mv ${pkg_prefix}/etc/bogofilter/bogofilter.cf.example ${pkg_prefix}/etc/bogofilter/bogofilter.cf

  install -dm755 ${pkg_prefix}/usr/share/${pkg_name}/contrib
  install -m644 contrib/* ${pkg_prefix}/usr/share/${pkg_name}/contrib/
}
