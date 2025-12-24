#!/bin/sh

# Example deploy hook - customize this for your service
# This script runs when the systemd path unit detects certificate changes

echo "Deploy hook executed for certificate renewal"

# Example: Restart a docker container
# docker restart nginx

# Example: Send HUP signal to reload without full restart
# docker kill -s HUP nginx

# Example: Update file permissions if needed
# USER_ID=1000
# GROUP_ID=1000
# for CERT_FILE in /etc/letsencrypt/live/*/; do
#   chown -R $USER_ID:$GROUP_ID "$CERT_FILE"
# done

echo "Deploy hook completed"
