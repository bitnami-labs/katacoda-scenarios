Let's Encrypt is a free Certificate Authority (CA) that issues SSL certificates valid for 90 days at a time. This section guides you through the process of replacing the default SSL certificate with a new certificate from Let's Encrypt.

1. Generate a Let's Encrypt SSL certificate using Bitnami's auto-configuration script, included by default in Bitnami application stacks. Replace the `example.com` domain name in the command below with your actual domain name, and the `user@example.com` email address with your actual email address.

    > Ensure that you have DNS entries for your domain name, with and without the `www` prefix, pointing to the public IP address of your instance before running the command below.

    `sudo /opt/bitnami/letsencrypt/scripts/generate-certificate.sh -m user@example.com -d example.com -d www.example.com`{{execute}}

    The auto-configuration script will copy the generated certificate and key to the correct place and also restart the Apache server.

2. Verify the contents of the new certificate, in particular checking that it uses the correct domain name:

    `openssl s_client -showcerts -connect localhost:443 | more`{{execute}}
