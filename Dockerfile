# Use the official Alpine image as a base
FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
    curl \
    dcron \
    certbot \
    certbot-dns-cloudflare \
    certbot-dns-route53

# Copy in files
COPY crontab /etc/crontabs/root
COPY renew-cert.sh /renew-cert.sh
COPY config /config
COPY start.sh /start.sh

# Run the start-up script
CMD ["sh", "/start.sh"]
