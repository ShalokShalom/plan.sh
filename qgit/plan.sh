pkg_origin=

pkg_name=qgit
pkg_version=2.7
pkg_description="Git repository viewer created using the Qt library, it uses git process (command-line calls) to extract data"
pkg_upstream_url="http://libre.tibirna.org/projects/qgit/wiki/QGit"
pkg_license=('GPL')
pkg_deps=('qt5-base' 'git')
pkg_build_deps=('cmake')
pkg_source=("https://github.com/tibirna/qgit/archive/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('855cfd067ed1202adac701c18c1fc0dd')

do_build() {  
  mkdir -p build
  cd build

  cmake ../qgit-${pkg_name}-${pkg_version} \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr
  make
}

do_package() {
  cd build

  make DESTDIR=${pkg_prefix} install
}
