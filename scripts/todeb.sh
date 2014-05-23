#!/bin/bash 

set -ex

pkgname=graphite-web

buildno="${1:?Give a build number}"
gitsha="$2"

: ${buildno:=$(date +%Y%m%d%H%M)}
: ${gitsha:=$(git show-ref -d --head --heads -s --abbrev=8 master)}

if [ -z "$gitsha" ]; then
  echo "Failed to get git SHA, give me one in \$2"
  exit 1
fi

build="${buildno}-${gitsha}"
arch=$(dpkg-architecture -qDEB_BUILD_ARCH)

tmpd=$(mktemp -d /tmp/debtmp.XXXXXX)
trap "rm -rf ${tmpd}" EXIT

builddir="${tmpd}/opt/prezi/${pkgname}/${build}"

mkdir -p $builddir

cp -a ./ $builddir/./

mkdir $tmpd/DEBIAN

cat > $tmpd/DEBIAN/control <<EOT
Package: ${pkgname}-${buildno}
Version: $build
Maintainer: endre.hirling@prezi.com
Architecture: ${arch}
Description: graphite-web with virtualenv included
EOT

cat > $tmpd/DEBIAN/postinst <<EOT
#!/bin/bash

set -e

virtualenv-tools --update-path=auto "/${builddir#$tmpd}/virtualenv"
update-alternatives --install /opt/prezi/$pkgname/current $pkgname-current /${builddir#$tmpd} 0

EOT
chmod 755 $tmpd/DEBIAN/postinst

debfilename="${debdir:+${debdir}/}${pkgname}-${buildno}_${build}_${arch}.deb"
dpkg-deb -b $tmpd "$debfilename" >/dev/null
echo $debfilename
