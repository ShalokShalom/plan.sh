pkg_origin=cosmos

pkg_name=geoip-database
pkg_version=20170608
pkg_description="GeoLite country geolocation database compiled by MaxMind"
pkg_upstream_url="http://www.maxmind.com/app/ip-location"
pkg_license=('custom:OPEN DATA LICENSE')
# version: curl -sI https://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz | grep ^Last-Modified: | cut -d' ' -f2- | tr -d '\r'
pkg_source=("GeoIP-${pkg_version}.dat.gz::http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz"
        "GeoIPv6-${pkg_version}.dat.gz::http://geolite.maxmind.com/download/geoip/database/GeoIPv6.dat.gz"
        "http://geolite.maxmind.com/download/geoip/database/LICENSE.txt")
noextract=("GeoIP-${pkg_version}.dat.gz"
           "GeoIPv6-${pkg_version}.dat.gz")
pkg_shasum=('5ac81d5de50c557be104e4c43f851c36'
         '83bdccfa4f13f743fe32ad7a14f93301'
         'a1381bd1aa0a0c91dc31b3f1e847cf4a')

do_build() {

  for _database_name in GeoIP GeoIPv6; do
    gunzip -c ${_database_name}-${pkg_version}.dat.gz >${_database_name}.dat
  done
}

do_package() {

  install -d ${pkg_prefix}/usr/share/GeoIP
  install -m0644 -t ${pkg_prefix}/usr/share/GeoIP GeoIP.dat GeoIPv6.dat

  install -Dm0644 LICENSE.txt ${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE.txt
}
