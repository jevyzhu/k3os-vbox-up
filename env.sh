#!/bin/bash

export ISO_URL="https://github.com/rancher/k3os/releases/download/v0.11.1/k3os-amd64.iso"
export ISO="./k3os-amd64.iso"
export SSH_PKF="./ssh_key"
export NODES_NUM=2        # k3s nodes number
export GATEWAY=192.168.56.1      # vbox gateway
export SERVER_IP=192.168.56.188  # k3s server ip
export TOKEN=jzk3sdev            # k3s token
export HTTP_PROXY=$http_proxy    # k3os http/https proxy

export SERVER_BOX=k3os-common-server.box
export SERVER_CONF=config-server.yml
export SERVER_VM_NAME=k3s-server
export SERVER_HOST_NAME=k3s-master

export AGENT_BOX=k3os-common-agent.box
export AGENT_CONF_BASE=config-agent
export AGENT_VM_NAME_BASE=k3s-agent
export AGENT_HOSTNAME_BASE=k3s-node

