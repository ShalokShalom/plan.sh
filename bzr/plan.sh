pkg_origin=cosmos

pkg_name=bzr
pkg_version=2.7.0
_pkg_version=2.7
pkg_description="Bazaar is a version control system that helps you track project history over time and to collaborate easily with others."
pkg_upstream_url="http://bazaar.canonical.com/en/"
pkg_license=('GPL')
pkg_deps=('python2')
pkg_source=("http://launchpad.net/bzr/${_pkg_version}/${pkg_version}/+download/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('8e5020502efd54f5925a14a456b88b89')

do_build() {
  cd ${pkg_name}-${pkg_version}
  sed -i 's|man/man1|share/man/man1|' setup.py

  python2 setup.py build
}

do_package() {
  cd ${pkg_name}-${pkg_version}
  python2 setup.py install --prefix=/usr --root=${pkg_prefix} --optimize=1

  install -D -m644 contrib/bash/bzr ${pkg_prefix}/etc/bash_completion.d/bzr
}
