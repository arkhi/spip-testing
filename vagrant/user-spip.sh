#! /bin/bash

cd /vagrant

echo "
`date '+%H:%M'`: Downloading spip from https://git.spip.net/SPIP/spip…
=============================================================================="
SPIP_ZIP_URL=https://git.spip.net/SPIP/spip/archive/spip-3.2.tar.gz;

curl --silent --show-error "$SPIP_ZIP_URL" \
    | tar --extract --gzip --no-same-owner --overwrite;

echo "
`date '+%H:%M'`: Creating and giving rights to mandatory folders…
=============================================================================="
cd spip
mkdir -p     IMG lib local plugins/auto tmp;
chmod -R 777 IMG lib local plugins/auto tmp;
cd -
