#!/bin/sh

# Ensure /cert exists
mkdir -p /certs

# Create the log file to be able to run tail
touch /var/log/cron.log

# Give execute permission to the scripts
chmod +x /renew-cert.sh /start.sh

# Run the cert renewal script on first run
/renew-cert.sh

# Start the cron daemon in the foreground and show the logs
# Added benefit of keeping container running
crond -f -l 2 &
tail -f /var/log/cron.log
