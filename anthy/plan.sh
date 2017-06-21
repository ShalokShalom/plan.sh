pkg_origin=cosmos

pkg_name=anthy
pkg_version=9100h
_pkg_version=37536
pkg_description="Hiragana text to Kana Kanji mixed text Japanese input method"
pkg_upstream_url="http://sourceforge.jp/projects/anthy/"
pkg_license=('LGPL' 'GPL')
pkg_deps=('glibc')
pkg_source=("https://osdn.net/projects/anthy/downloads/${_pkg_version}/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('1f558ff7ed296787b55bb1c6cf131108')

do_build() {

    ./configure --prefix=/usr \
        --sysconfdir=/etc \
        --disable-static
    make
}

do_package() {
        
    make EMACS=emacs DESTDIR=${pkg_prefix} install
}
