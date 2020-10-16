#!/bin/bash

set -euxo pipefail

. env.sh

SSH_PUB_KEY=$(cat $SSH_PKF.pub)

# generate server config
cp config-server.yml.jinja2  $SERVER_CONF
sed -i "s#{{_ssh_key_}}#$SSH_PUB_KEY#g" $SERVER_CONF
sed -i "s/{{_hostname_}}/$SERVER_HOST_NAME/g" $SERVER_CONF
sed -i "s/{{_private_ip_}}/$SERVER_IP/g" $SERVER_CONF
sed -i "s/{{_private_gw_}}/$GATEWAY/g" $SERVER_CONF
sed -i "s/{{_token_}}/$TOKEN/g" $SERVER_CONF
sed -i "s#{{_http_proxy_}}#$HTTP_PROXY#g" $SERVER_CONF


# generate every agent's configs
for i in $(eval echo {1..$NODES_NUM}); do
    AGENT_CONF=$AGENT_CONF_BASE-$i.yml

    NAME=$AGENT_HOSTNAME_BASE-$i
    cp config-agent.yml.jinja2  $AGENT_CONF
    sed -i "s#{{_ssh_key_}}#$SSH_PUB_KEY#g" $AGENT_CONF
    sed -i "s/{{_hostname_}}/$NAME/g" $AGENT_CONF
    sed -i "s/{{_server_ip_}}/$SERVER_IP/g" $AGENT_CONF
    sed -i "s/{{_token_}}/$TOKEN/g" $AGENT_CONF
    sed -i "s#{{_http_proxy_}}#$HTTP_PROXY#g" $AGENT_CONF
done


VM_ARR=()
###### update config ######
## server
VM_NAME=$SERVER_VM_NAME
vagrant upload $SERVER_CONF $VM_NAME
vagrant ssh $VM_NAME -- "sudo cp $SERVER_CONF /var/lib/rancher/k3os/config.yaml && sudo reboot"
echo ":-> VM updated:$VM_NAME"
VM_ARR+=($VM_NAME)

## agent
for i in $(eval echo {1..$NODES_NUM}); do
    VM_NAME=$AGENT_VM_NAME_BASE-$i
    AGENT_CONF=$AGENT_CONF_BASE-$i.yml
    vagrant upload $AGENT_CONF $VM_NAME
    vagrant ssh $VM_NAME -- "sudo cp $AGENT_CONF /var/lib/rancher/k3os/config.yaml && sudo reboot"
    echo ":-> VM updated:$VM_NAME"
    VM_ARR+=($VM_NAME)
done

echo 
for value in "${VM_ARR[@]}"
do
     echo "to ssh vms:=>"
     echo "------------------"
     echo "vagrant ssh $value"
     echo "------------------"
done

rm -fr *.yml
