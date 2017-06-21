pkg_origin=cosmos

pkg_name=ttf-raleway
pkg_version=1
pkg_description="A sans-serif typeface"
pkg_upstream_url="http://theleagueofmoveabletype.com/raleway/"
pkg_license=('OFL')
pkg_deps=('fontconfig' 'xorg-font-utils')
install=ttf.install
#pkg_source=('http://www.impallari.com/media/uploads/prosources/update-35-source.zip')
pkg_source=('Raleway.zip')
pkg_shasum=('1d0fd5fe6aa19599eb390f5ab8cc2eb1')

do_package() {
    install -d ${CACHE_PATH}/usr/share/fonts/TTF/
    install -m644 ${CACHE_PATH}/Raleway* ${CACHE_PATH}/usr/share/fonts/TTF/
    
    install -Dm644 ${CACHE_PATH}/OFL.txt ${CACHE_PATH}/usr/share/licenses/${pkg_name}/OFL.txt
}
