pkg_origin=cosmos

pkg_name=enscript
pkg_version=1.6.6
pkg_description="Convert ASCII files to PostScript suitable for printing"
pkg_upstream_url="http://www.gnu.org/software/enscript/enscript.html"
backup=('etc/enscript/enscript.cfg')
pkg_deps=('glibc')
pkg_license=('GPL3')
pkg_source=("http://ftp.gnu.org/gnu/enscript/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('3acc242b829adacabcaf28533f049afd')

do_build() {

  ./configure --prefix=/usr \
              --sysconfdir=/etc/enscript \
              --mandir=/usr/share/man \
              --infodir=/usr/share/info 
  make
}

do_package() {

  make install \
       prefix=${pkg_prefix}/usr \
       sysconfdir=${pkg_prefix}/etc/enscript \
       mandir=${pkg_prefix}/usr/share/man \
       infodir=${pkg_prefix}/usr/share/info
}

