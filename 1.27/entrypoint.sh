#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail
#set -o xtrace # Uncomment this line for debugging purpose

#### h5bp
REPO_NAME="h5bp/server-configs-nginx"
REPO_URL="https://github.com/$REPO_NAME.git"
FALLBACK_DIR="${NGINX_H5BP_FALLBACK_DIR:-/app/conf/$REPO_NAME}"
DEST_DIR="/opt/bitnami/nginx/conf"

if [ -d "$FALLBACK_DIR/.git" ]; then
	cd "$FALLBACK_DIR"
	git pull >/dev/null 2>&1 || true
else
	#https://stackoverflow.com/a/12569731/3929620
	git clone "$REPO_URL" "$FALLBACK_DIR" >/dev/null 2>&1 || true
fi

if [ -f "$FALLBACK_DIR/mime.types" ]; then
	cp "$FALLBACK_DIR/mime.types" "$DEST_DIR"
fi

if [ -d "$FALLBACK_DIR/h5bp" ]; then
	cp -r "$FALLBACK_DIR/h5bp" "$DEST_DIR"
fi

####
#FIXED - [emerg] "gzip" directive is duplicate...
sed -i \
	-e 's/^\(\s*gzip.*\)/#\1/' \
	nginx.conf

{
	echo ''
	echo 'include "/opt/bitnami/nginx/conf/custom.d/*.conf";'
} >>nginx.conf

####

#https://stackoverflow.com/a/46433245/3929620
# shellcheck source=/dev/null
. /opt/bitnami/scripts/nginx/entrypoint.sh
