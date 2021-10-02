#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace # Uncomment this line for debugging purpose


#### h5bp

cd /opt/bitnami/nginx/conf;

#https://stackoverflow.com/a/12569731/3929620
git clone https://github.com/h5bp/server-configs-nginx.git;

if [ -f "server-configs-nginx/mime.types" ]; then
  mv server-configs-nginx/mime.types .;
fi

if [ -d "server-configs-nginx/h5bp" ]; then
  mv server-configs-nginx/h5bp .;
fi

rm -Rf server-configs-nginx;


#FIXED - [emerg] "gzip" directive is duplicate...
sed -i \
  -e 's/^\(\s*gzip.*\)/#\1/' \
  nginx.conf;

{
  echo '';
  echo "include \"/opt/bitnami/nginx/conf/custom.d/*.conf\";";
} >> nginx.conf;


####

#https://stackoverflow.com/a/46433245/3929620
. /opt/bitnami/scripts/nginx/entrypoint.sh

}