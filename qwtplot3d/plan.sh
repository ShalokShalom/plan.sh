pkg_origin=cosmos
# $Id: PKGBUILD 64675 2010-01-21 21:29:39Z eric $
# Maintainer: damir <damir@archlinux.org>

pkg_name=qwtplot3d
pkg_version=0.2.7
origver=0.2.7
pkg_description="Qt/OpenGL-based C++ programming library containing 3d-widgets"
pkg_license=('custom:zlib')
pkg_upstream_url="http://qwtplot3d.sourceforge.net/"
pkg_deps=('qt>=4.3' 'qwt>=5.0.2')
pkg_source=("http://downloads.sourceforge.net/sourceforge/qwtplot3d/qwtplot3d-$origver.tgz"
        qwtplot3d-gcc44.patch)
pkg_shasum=('2f14660152e2e26bfeaaeec479ed9f2b' '92ad261ed5344bc773cba05b324cfe74')
sha1sums=('4463fafb8420a91825e165da7a296aaabd70abea' '52fa169b651a98550f8a8391ddf52e0eaeb2c215')

do_build() {
    patch -p1 < ../qwtplot3d-gcc44.patch || return 1
  #  . /etc/profile.d/qt3.sh
    # build qwt:
    qmake qwtplot3d.pro
    make || return 1

    # install qwtplot3d: (by hand, because the Makefile do not provide a "install:")
    mkdir -p $startdir/pkg/usr/{include/qwtplot3d,lib}
    # mkdir -p $startdir/pkg/usr/man/man3 .. no manpages yet

    for n in include/* ; do
     cp -d $n $startdir/pkg/usr/include/qwtplot3d || return 1
    done

    for n in lib/libqwtplot3d.so* ; do
     cp -d $n $startdir/pkg/usr/lib || return 1
    done

    # for n in doc/man/man3/*.3 ; do
    #  install -m 644 $n $startdir/pkg/usr/man/man3
    # done
}

