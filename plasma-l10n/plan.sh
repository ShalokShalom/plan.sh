pkg_origin=

pkg_name=plasma-l10n
pkg_version=5.10.0
pkg_description="Language packs for Plasma 5"
pkg_upstream_url="https://websvn.kde.org/trunk/l10n-kf5/"
pkg_license=('GPL')
pkg_deps=('ki18n')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'gettext' 'subversion' 'imake')
pkg_source=("svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ar"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ast"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/bg"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ca"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/cs"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/es"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/et"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/de"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/fr"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/gl"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/hr"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/hu"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/id"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/it"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ja"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/nl"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/pl"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/pt"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/pt_BR"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ro"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ru"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/sr"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/sv"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/tr"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/zh_CN"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/zh_TW"
        'autogen.sh')
pkg_shasum=('SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         '2c79e790e4ce39f654ddf9755975925f')

_locales=(ar ast bg ca cs es et de fr gl hr hu id it ja nl pl pt pt_BR ro ru sr sv tr zh_CN zh_TW)
 
do_build() {
  for l in ${_locales[@]}; do
    ${CACHE_PATH}/autogen.sh $l
    mkdir -p build/$l
    cd build/$l
    cmake ../../$l \
      -DCMAKE_INSTALL_PREFIX=/usr \
      -DCMAKE_BUILD_TYPE=Release
    make
    cd ../..
  done
}
 
do_package() {
  for l in ${_locales[@]}; do
    cd build/$l
    make DESTDIR=${pkg_prefix} install
    cd ../..
  done
}
