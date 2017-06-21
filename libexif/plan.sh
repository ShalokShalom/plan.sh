pkg_origin=cosmos


pkg_name=libexif
pkg_version=0.6.21
pkg_description="A library to parse an EXIF file and read the data from those tags"
pkg_license=('LGPL')
pkg_upstream_url="http://sourceforge.net/projects/libexif"
pkg_deps=('glibc')
pkg_source=("http://downloads.sf.net/sourceforge/libexif/${pkg_name}-${pkg_version}.tar.bz2")
pkg_shasum=('27339b89850f28c8f1c237f233e05b27')

do_build() {
  
  ./configure --prefix=/usr 
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
