#!/bin/bash

set -euo pipefail

. env.sh

vagrant box remove $SERVER_BOX || :
vagrant box remove $AGENT_BOX || :

vagrant up

. vm-config.sh
