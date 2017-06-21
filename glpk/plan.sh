pkg_origin=cosmos

pkg_name=glpk
pkg_version=4.62
pkg_description="GNU Linear Programming Kit : solve LP, MIP and other problems."
pkg_upstream_url="https://www.gnu.org/software/glpk/glpk.html"
pkg_license=('GPL')
pkg_deps=('glibc')
pkg_source=("https://ftp.gnu.org/gnu/glpk/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('ad4f681463db1b78ad88b956b736fa25')

do_build() {

  ./configure --prefix=/usr
  make CFLAGS="$CFLAGS -fPIC"  
}

do_package(){
  make DESTDIR=${pkg_prefix} install
  
  install -Dm644 doc/glpk.pdf ${pkg_prefix}/usr/share/doc/glpk/glpk.pdf
  install -Dm644 doc/gmpl.pdf ${pkg_prefix}/usr/share/doc/glpk/gmpl.pdf
}
