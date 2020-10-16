#!/bin/bash

set -euxo pipefail

. env.sh

vagrant box add --force --name $SERVER_BOX ./$SERVER_BOX
vagrant box add --force --name $SERVER_BOX ./$AGENT_BOX

vagrant up

. vm-config.sh
