pkg_origin=cosmos

pkg_name=docbook-xml
pkg_version=4.5
pkg_description="A widely used XML scheme for writing documentation and help"
pkg_upstream_url="http://www.oasis-open.org/docbook/"
pkg_license=('MIT')
pkg_deps=('libxml2')
install=docbook-xml.install
pkg_source=("http://www.docbook.org/xml/4.5/docbook-xml-4.5.zip"
        "http://www.docbook.org/xml/4.4/docbook-xml-4.4.zip"
        "http://www.docbook.org/xml/4.3/docbook-xml-4.3.zip"
        "http://www.docbook.org/xml/4.2/docbook-xml-4.2.zip"
        "http://www.docbook.org/xml/4.1.2/docbkx412.zip"
        'LICENSE')
noextract=('docbook-xml-4.5.zip' 'docbook-xml-4.4.zip' 'docbook-xml-4.3.zip' 'docbook-xml-4.2.zip' 'docbkx412.zip')
pkg_shasum=('03083e288e87a7e829e437358da7ef9e'
         'cbb04e9a700955d88c50962ef22c1634'
         'ab200202b9e136a144db1e0864c45074'
         '73fe50dfe74ca631c1602f558ed8961f'
         '900d7609fb7e6d78901b357e4acfbc17'
         '50e1eea70bc071b812e963e65af6707e')

do_package() {
  for ver in 4.2 4.3 4.4 4.5; do
    mkdir docbook-xml-${ver}
    pushd docbook-xml-${ver}
    bsdtar xf "${CACHE_PATH}/docbook-xml-${ver}.zip"
    mkdir -p "${pkg_prefix}/usr/share/xml/docbook/xml-dtd-${ver}"
    cp -dRf docbook.cat *.dtd ent/ *.mod \
        "${pkg_prefix}/usr/share/xml/docbook/xml-dtd-${ver}/" 
    popd
  done
  mkdir docbook-xml-4.1.2
  pushd docbook-xml-4.1.2
  bsdtar xf "${CACHE_PATH}/docbkx412.zip"
  mkdir -p "${pkg_prefix}/usr/share/xml/docbook/xml-dtd-4.1.2"
  cp -dRf docbook.cat *.dtd ent/ *.mod \
      "${pkg_prefix}/usr/share/xml/docbook/xml-dtd-4.1.2/" 
  popd

  mkdir -p "${pkg_prefix}/etc/xml"
  xmlcatalog --noout --create "${pkg_prefix}/etc/xml/docbook-xml" 

  # V4.1.2
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/docbookx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML CALS Table Model V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/calstblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML CALS Table Model V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/calstblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/soextblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Information Pool V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbpoolx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbhierx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Additional General Entities V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbgenent.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Notations V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbnotnx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Character Entities V4.1.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.1.2/dbcentx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.1.2" \
    "file:///usr/share/xml/docbook/xml-dtd-4.1.2" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.1.2" \
    "file:///usr/share/xml/docbook/xml-dtd-4.1.2" \
    "${pkg_prefix}/etc/xml/docbook-xml"

  # V4.2
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/docbookx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook CALS Table Model V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/calstblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/soextblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Information Pool V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbpoolx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Document Hierarchy V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbhierx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Additional General Entities V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbgenent.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Notations V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbnotnx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Character Entities V4.2//EN" \
    "http://www.oasis-open.org/docbook/xml/4.2/dbcentx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.2" \
    "file:///usr/share/xml/docbook/xml-dtd-4.2" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.2" \
    "file:///usr/share/xml/docbook/xml-dtd-4.2" \
    "${pkg_prefix}/etc/xml/docbook-xml"

  # V4.3
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/docbookx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook CALS Table Model V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/calstblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/soextblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Information Pool V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbpoolx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Document Hierarchy V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbhierx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Additional General Entities V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbgenent.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Notations V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbnotnx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Character Entities V4.3//EN" \
    "http://www.oasis-open.org/docbook/xml/4.3/dbcentx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.3" \
    "file:///usr/share/xml/docbook/xml-dtd-4.3" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.3" \
    "file:///usr/share/xml/docbook/xml-dtd-4.3" \
    "${pkg_prefix}/etc/xml/docbook-xml"

  # V4.4
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/docbookx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook CALS Table Model V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/calstblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML HTML Tables V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/htmltblx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/soextblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Information Pool V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbpoolx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook Document Hierarchy V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbhierx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Additional General Entities V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbgenent.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Notations V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbnotnx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook Character Entities V4.4//EN" \
    "http://www.oasis-open.org/docbook/xml/4.4/dbcentx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.4" \
    "file:///usr/share/xml/docbook/xml-dtd-4.4" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.4" \
    "file:///usr/share/xml/docbook/xml-dtd-4.4" \
    "${pkg_prefix}/etc/xml/docbook-xml"

  # V4.5
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML V4.5//EN" \
    "http://www.oasis-open.org/docbook/xml/4.5/docbookx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD DocBook XML CALS Table Model V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/calstblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//DTD XML Exchange Table Model 19990315//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/soextblx.dtd" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Information Pool V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbpoolx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML Document Hierarchy V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbhierx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ELEMENTS DocBook XML HTML Tables V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/htmltblx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Notations V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbnotnx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Character Entities V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbcentx.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "public" \
    "-//OASIS//ENTITIES DocBook XML Additional General Entities V4.5//EN" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5/dbgenent.mod" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteSystem" \
    "http://www.oasis-open.org/docbook/xml/4.5" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
    "${pkg_prefix}/etc/xml/docbook-xml"
  xmlcatalog --noout --add "rewriteURI" \
    "http://www.oasis-open.org/docbook/xml/4.5" \
    "file:///usr/share/xml/docbook/xml-dtd-4.5" \
    "${pkg_prefix}/etc/xml/docbook-xml"

# license
  install -D -m644 "${CACHE_PATH}/LICENSE" "${pkg_prefix}/usr/share/licenses/${pkg_name}/LICENSE"
}
