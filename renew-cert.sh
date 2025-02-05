#!/bin/sh

# Load config
. ./config

export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY

date

echo "Running certbot request for domain: $DOMAIN"

# Build the Certbot command with Route53 Challenge
PATH_SAFE_DOMAIN="${DOMAIN#\*\.*}"

CBC="certbot certonly --dns-route53 -d \"$DOMAIN\" --non-interactive --agree-tos --email \"$EMAIL\" -v --deploy-hook \"cp -r /etc/letsencrypt/live/$PATH_SAFE_DOMAIN /certs/\""

# Staging vs Production
if [ "$STAGING" = true ]; then
  CBC="$CBC --staging"
fi

# Execute the command
eval $CBC "$@"
