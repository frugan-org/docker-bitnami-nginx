#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace # Uncomment this line for debugging purpose


#### h5bp

cd /opt/bitnami/nginx/conf;

#https://stackoverflow.com/a/12569731/3929620
git clone https://github.com/h5bp/server-configs-nginx.git h5bp;


####

#https://stackoverflow.com/a/46433245/3929620
. /opt/bitnami/scripts/nginx/entrypoint.sh
