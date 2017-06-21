pkg_origin=cosmos

pkg_name=enchant
pkg_version=1.6.1
_pkg_version=1-6-1
pkg_description="A wrapper library for generic spell checking"
pkg_upstream_url="http://www.abisource.com/enchant/"
pkg_license=('LGPL')
pkg_deps=('aspell' 'dbus-glib' 'hunspell' 'hspell')
#pkg_source=("http://www.abisource.com/downloads/enchant/${pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_source=("https://github.com/AbiWord/enchant/archive/enchant-${_pkg_version}.tar.gz")
pkg_shasum=('dcf5a2e2d0c3e35c34ab1c5b4f7382cb')

do_build() {
  
  ./autogen.sh
  ./configure --prefix=/usr \
    --disable-static \
    --disable-ispell \
    --with-myspell-dir=/usr/share/myspell 
  make 
}

do_package() {
  
  make DESTDIR=${pkg_prefix} install 
}
