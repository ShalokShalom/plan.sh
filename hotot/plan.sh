pkg_origin=

pkg_name=hotot
pkg_version=0.9.8.16
pkg_description="Lightweight & open source microblogging software (twitter identi.ca)"
pkg_upstream_url="http://www.hotot.org/"
pkg_license=('LGPL3')
pkg_deps=('qt5-webkit')
pkg_build_deps=('cmake' 'intltool' 'python2')
pkg_source=("https://github.com/ManiacTwister/Hotot/archive/${pkg_version}.tar.gz")
pkg_shasum=('5cae5f3b757dfdd476f68697959121f2')

do_build() {
  cd Hotot-${pkg_version}
  mkdir build 
  
  cd build
  cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
           -DWITH_GTK=OFF \
           -DWITH_QT=OFF \
           -DWITH_QT5=ON \
           -DWITH_CHROME=OFF 
  make
}

do_package() {
  cd Hotot-${pkg_version}/build
  make DESTDIR=${pkg_prefix}/ install
  
  # fix user retweets error
  find ${pkg_prefix} -name lib.twitter.js -exec \
    sed -i 's/1\/statuses\/retweeted_by/1.1\/statuses\/retweets_of/' {} \;
  find ${pkg_prefix} -name lib.twitter.js -exec \
    sed -i 's/1\/statuses\/retweeted_to_me/1.1\/statuses\/retweets_of_me/' {} \;
  
  rm ${pkg_prefix}/usr/share/applications/hotot.desktop
}
