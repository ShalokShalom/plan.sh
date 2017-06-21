pkg_origin=cosmos

pkg_name=chemical-mime-data
pkg_version=0.1.94
pkg_description="Collection of data files to add support for various chemical MIME types"
pkg_upstream_url="http://chemical-mime.sourceforge.net/"
pkg_license=('LGPL')
pkg_deps=('xdg-utils' 'shared-mime-info' 'hicolor-icon-theme' 'gnome-mime-data')
pkg_build_deps=('intltool' 'libxslt' 'imagemagick' 'librsvg')
pkg_source=("http://downloads.sourceforge.net/chemical-mime/${pkg_name}-${pkg_version}.tar.gz")
pkg_shasum=('ca54b5fbd7f43ee5380e394bfd273b95')

do_build() {
    
    ./configure --prefix=/usr --disable-update-database
    make
}

do_package() {
    
    make DESTDIR=${pkg_prefix} install
}
