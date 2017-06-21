pkg_origin=

pkg_name=qtfm
pkg_version=5.9
pkg_description="A lightweight file manager"
pkg_upstream_url="https://www.linux-apps.com/content/show.php/QtFM?content=158787"
pkg_license=('GPL')
pkg_deps=('qt5-declarative' 'file' 'desktop-file-utils')
categories=('system')
pkg_source=("https://dl.opendesktop.org/api/files/download/id/1466643163/158787-qtfm.zip")
pkg_shasum=('1a94bd7fbe99e87f530dc9bc1d7a8c45')


do_build() {
  cd ${pkg_name}
  	
  /usr/lib/qt5/bin/qmake
  make
}

do_package() {
  cd ${pkg_name}
	
  make INSTALL_ROOT=${pkg_prefix} install
}

