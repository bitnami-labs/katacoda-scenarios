Let's Encrypt is a free Certificate Authority (CA) that issues SSL certificates valid for 90 days at a time. This section guides you through the process of replacing the default SSL certificate with a new certificate from Let's Encrypt.

1. Generate a Let's Encrypt SSL certificate using Bitnami's auto-configuration script, included by default in Bitnami application stacks. The auto-configuration script will generate a certificate, copy the generated certificate and key to the correct place, and restart the Apache server.

    `sudo /opt/bitnami/letsencrypt/scripts/generate-certificate.sh -m user@example.com -d example.com -d www.example.com`{{execute}}

    When you execute the previous command in the interactive Katacoda shell, it will fail with an error. This is because Bitnami's auto-configuration script expects the instance to to be publicly available at the same domain and IP address for validation. Katacoda works behind a proxy that does not allow this behavior. However, the command will work without error on your instance. 

    > Before running the command above on your instance, ensure that you have DNS entries for your domain name, with and without the `www` prefix, pointing to the public IP address of your instance, and replace the `example.com` domain name and `user@example.com` email address with your actual domain name and email address.
    
2. Verify the contents of the new certificate, in particular checking that it uses the correct domain name:

    `openssl s_client -showcerts -connect localhost:443 | more`{{execute}}
