pkg_origin=

pkg_name=notepad
pkg_version=0.2
pkg_description="Very simple text-editor for use during kf5/plasma transition"
pkg_upstream_url="http://kaosx.us"
pkg_license=('GPL3')
pkg_deps=('qt5-base')
pkg_source=("git://github.com/KaOSx/notepad.git"
        'notepad.desktop')
pkg_shasum=('SKIP'
         'fbf1c7bd24b595ecd1fb5305e2bc9c2a')

do_build() {
   cd notepad

   /usr/lib/qt5/bin/qmake 
   make
}

do_package() {
   cd notepad
   
   mkdir -p ${pkg_prefix}/usr/bin
   cp Notepad ${pkg_prefix}/usr/bin
   
   mkdir -p ${pkg_prefix}/usr/share/applications
   install -m644 -p ${CACHE_PATH}/notepad.desktop ${pkg_prefix}/usr/share/applications
}
