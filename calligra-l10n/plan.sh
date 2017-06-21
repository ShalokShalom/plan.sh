pkg_origin=
pkg_name=calligra-l10n
pkg_version=3.0.0
pkg_description="Localization for Calligra"
pkg_upstream_url="https://websvn.kde.org/trunk/l10n-kf5/"
pkg_license=('GPL')
pkg_deps=('ki18n')
pkg_build_deps=('extra-cmake-modules' 'kdoctools' 'gettext' 'subversion' 'imake')
        'calligra-l10n-ca'
        'calligra-l10n-ca@valencia'
        'calligra-l10n-cs'
        'calligra-l10n-da'
        'calligra-l10n-de'
        'calligra-l10n-el'
        'calligra-l10n-en_GB'
        'calligra-l10n-es'
        'calligra-l10n-et'
        'calligra-l10n-fi'
        'calligra-l10n-fr'
        'calligra-l10n-gl'
        'calligra-l10n-hu'
        'calligra-l10n-it'
        'calligra-l10n-ja'
        'calligra-l10n-kk'
        'calligra-l10n-nb'
        #'calligra-l10n-nds'
        'calligra-l10n-nl'
        'calligra-l10n-pl'
        'calligra-l10n-pt'
        'calligra-l10n-pt_BR'
        'calligra-l10n-ru'
         'calligra-l10n-sk'
         #'calligra-l10n-sl'
        'calligra-l10n-sv'
        #'calligra-l10n-tr'
        'calligra-l10n-uk'
        'calligra-l10n-zh_CN'
        'calligra-l10n-zh_TW')
        'calligra-l10n-ca'
        'calligra-l10n-ca@valencia'
        'calligra-l10n-cs'
        'calligra-l10n-da'
        'calligra-l10n-de'
        'calligra-l10n-el'
        'calligra-l10n-en_GB'
        'calligra-l10n-es'
        'calligra-l10n-et'
        'calligra-l10n-fi'
        'calligra-l10n-fr'
        'calligra-l10n-gl'
        'calligra-l10n-hu'
        'calligra-l10n-it'
        'calligra-l10n-ja'
        'calligra-l10n-kk'
        'calligra-l10n-nb'
        #'calligra-l10n-nds'
        'calligra-l10n-nl'
        'calligra-l10n-pl'
        'calligra-l10n-pt'
        'calligra-l10n-pt_BR'
        'calligra-l10n-ru'
         'calligra-l10n-sk'
         #'calligra-l10n-sl'
        'calligra-l10n-sv'
        #'calligra-l10n-tr'
        'calligra-l10n-uk'
        'calligra-l10n-zh_CN'
        'calligra-l10n-zh_TW')
pkg_source=("svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ar"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ast"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/bg"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ca"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/cs"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/es"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/et"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/de"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/fr"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/hr"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/hu"
        #"svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/id"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/it"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/nl"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/pl"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/pt"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/pt_BR"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ro"
        "svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/ru"
        #"svn://anonsvn.kde.org/home/kde/trunk/l10n-kf5/sr"
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
        # 'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         #'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         'SKIP'
         '880a2a7f218a8f326d0f611513924d2c')

_locales=(ar ast bg ca cs es et de fr hr hu it nl pl pt pt_BR ro ru sv tr zh_CN zh_TW)
 
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
    rm ${pkg_prefix}/usr/share/locale/$l/LC_MESSAGES/krita.mo
    rm ${pkg_prefix}/usr/share/locale/$l/LC_MESSAGES/*kexi*.mo
    cd ../..
  done
}
