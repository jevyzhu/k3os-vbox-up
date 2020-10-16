#!/bin/bash

set -euo pipefail

. env.sh

rm -fr output-*
rm -fr *.yml

if [[ ! -f "$ISO" ]]; then
  wget -O $ISO $ISO_URL
fi

ISO_MD5=md5:$(md5sum $ISO | awk '{print $1}')

if [[ ! ( -f "$SSH_PKF" &&  -f "$SSH_PKF.pub" ) ]]; then
  ssh-keygen -t RSA -N '' -m PEM  -f $SSH_PKF
fi

SSH_PUB_KEY=$(cat $SSH_PKF.pub)

###### server box build ######

# generate config
SERVER_CONF_COMMON=./tmp1.yml
cp config-server-base.yml.jinja2  $SERVER_CONF_COMMON
sed -i "s#{{_ssh_key_}}#$SSH_PUB_KEY#g" $SERVER_CONF_COMMON
sed -i "s/{{_hostname_}}/$SERVER_HOST_NAME/g" $SERVER_CONF_COMMON

# build box
rm -fr output-k3os
packer build -var vm_name=$SERVER_BOX  \
    -var config=$SERVER_CONF_COMMON \
    -var iso_url=$ISO \
    -var iso_checksum=$ISO_MD5 \
    -var ssh_pkf=$SSH_PKF  \
    .

###### server box build end ######


###### agent box build ######

AGENT_CONF_COMMON=./tmp2.yml
cp config-agent-base.yml.jinja2  $AGENT_CONF_COMMON
sed -i "s#{{_ssh_key_}}#$SSH_PUB_KEY#g" $AGENT_CONF_COMMON

#agent box build
packer build -var vm_name=$AGENT_BOX \
    -var config=$AGENT_CONF_COMMON \
    -var iso_url=$ISO \
    -var iso_checksum=$ISO_MD5 \
    -var ssh_pkf=$SSH_PKF  \
    .
###### agent box build end ######

echo 
echo "Box Build Finished from: $ISO"
echo

