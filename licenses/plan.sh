pkg_origin=cosmos

pkg_name=licenses
pkg_version=20151223
pkg_description="The standard licenses distribution package"
pkg_license=('custom:none')
pkg_upstream_url="http://kaosx.us"
pkg_source=(apache-2.0.txt::http://www.apache.org/licenses/LICENSE-2.0.txt
        cc-by-3.0.txt
        cc-by-nc-3.0.txt
        cc-by-nc-nd-3.0.txt
        cc-by-nc-sa-3.0.txt
        cc-by-nd-3.0.txt
        cc-by-sa-3.0.txt
        cc-readme.txt
        cddl-1.0.txt
        eclipse-1.0.txt
        http://www.gnu.org/licenses/agpl-3.0.txt
        http://www.gnu.org/licenses/gpl-2.0.txt
        http://www.gnu.org/licenses/gpl-3.0.txt
        http://www.gnu.org/licenses/lgpl-2.1.txt
        http://www.gnu.org/licenses/lgpl-3.0.txt
        http://www.gnu.org/licenses/fdl-1.2.txt
        http://www.gnu.org/licenses/fdl-1.3.txt
        http://www.latex-project.org/lppl.txt
        mpl-1.1.txt::http://www.mozilla.org/MPL/2.0/index.txt
        perlartistic.txt
        artistic-2_0.txt
        php-3.0.txt::http://www.php.net/license/3_0.txt
        ruby-license.txt::http://www.ruby-lang.org/en/about/license.txt
        cpl-1.0.txt
        python-2.txt
        w3c.txt
        ZopePublicLicense.txt)
pkg_shasum=('3b83ef96387f14655fc854ddc3c6bd57'
         'ffb24d1bbf8b83d373f0b8edc3feb0c6'
         '682a5e3b03510ba46c4f566478c871bc'
         '166b65b71e44630b436bfe937c4c0b73'
         '89bca4a2dde8b7d39c27a1dc24078932'
         '2502517d13d8136fffaf248489ad0870'
         '5367190077e12a7f55403d531ef3998e'
         '019bc72509b18a804f0ea8fd2bab1932'
         '6cb35f3976cd093011967fa1abbce386'
         'f300afd598546add034364cd0a533261'
         '73f1eb20517c55bf9493b7dd6e480788'
         'b234ee4d69f5fce4486a80fdaf4a4263'
         'd32239bcb673463ab874e80d47fae504'
         '4fbd65380cdd255951079008b364516c'
         'e6a600fd5e1d9cbde2d983680233ad02'
         '24ea4c7092233849b4394699333b5c56'
         '10b9de612d532fdeeb7fe8fcd1435cc6'
         '9f4337828d782bdea41f03dd2ad1b808'
         '815ca599c9df247a0c7f619bab123dad'
         'd09c120ca7db95ef2aeecec0cb08293b'
         'b4a94da2a1f918b217ef5156634fc9e0'
         'a45bb1bbeed9e26b26c5763df1d3913d'
         '8a960b08d972f43f91ae84a6f00dcbfb'
         'f083e41c43db25e18f36c91e57750b64'
         'a055911c32fb4ed6e96c453ceaeba857'
         '6f2095b5d61770740852873b195a4d21'
         'dc8502850eab9e1ff330a12d7ca18a19')

do_package() {
  cd $pkg_prefix
  mkdir -p usr/share/licenses/common
  cd usr/share/licenses/common

  mkdir AGPL3
  cp $CACHE_PATH/agpl-3.0.txt AGPL3/license.txt
  ln -s AGPL3 AGPL

  mkdir Apache
  cp $CACHE_PATH/apache-2.0.txt Apache/license.txt
  ln -s Apache APACHE

  mkdir Artistic2.0
  cp $CACHE_PATH/artistic-2_0.txt Artistic2.0/license.txt

  mkdir CCPL
  cp $CACHE_PATH/cc-by-3.0.txt CCPL/
  cp $CACHE_PATH/cc-by-nc-3.0.txt CCPL/
  cp $CACHE_PATH/cc-by-nc-nd-3.0.txt CCPL/
  cp $CACHE_PATH/cc-by-nc-sa-3.0.txt CCPL/
  cp $CACHE_PATH/cc-by-nd-3.0.txt CCPL/
  cp $CACHE_PATH/cc-by-sa-3.0.txt CCPL/
  cp $CACHE_PATH/cc-readme.txt CCPL/

  mkdir CDDL
  cp $CACHE_PATH/cddl-1.0.txt CDDL/license.txt

  mkdir CPL
  cp $CACHE_PATH/cpl-1.0.txt CPL/license.txt

  mkdir EPL
  cp $CACHE_PATH/eclipse-1.0.txt EPL/license.txt

  mkdir {GPL2,GPL3}
  cp $CACHE_PATH/gpl-2.0.txt GPL2/license.txt
  cp $CACHE_PATH/gpl-3.0.txt GPL3/license.txt
  ln -s GPL2 GPL

  mkdir {FDL1.2,FDL1.3}
  cp $CACHE_PATH/fdl-1.2.txt FDL1.2/license.txt
  cp $CACHE_PATH/fdl-1.3.txt FDL1.3/license.txt
  ln -s FDL1.2 FDL

  mkdir {LGPL2.1,LGPL3}
  cp $CACHE_PATH/lgpl-2.1.txt LGPL2.1/license.txt
  cp $CACHE_PATH/lgpl-3.0.txt LGPL3/license.txt
  ln -s LGPL2.1 LGPL

  mkdir LPPL
  cp $CACHE_PATH/lppl.txt LPPL/license.txt

  mkdir MPL
  cp $CACHE_PATH/mpl-1.1.txt MPL/license.txt

  mkdir PerlArtistic
  cp $CACHE_PATH/perlartistic.txt PerlArtistic/license.txt

  mkdir PHP
  cp $CACHE_PATH/php-3.0.txt PHP/license.txt
  
  mkdir PSF
  cp $CACHE_PATH/python-2.txt PSF/license.txt

  mkdir RUBY
  cp $CACHE_PATH/ruby-license.txt RUBY/license.txt
  
  mkdir W3C
  cp $CACHE_PATH/w3c.txt W3C/license.txt

  mkdir ZPL
  cp $CACHE_PATH/ZopePublicLicense.txt ZPL/license.txt
}
