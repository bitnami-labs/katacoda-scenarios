As an alternative to Let's Encrypt, you can also use a self-signed SSL certificate or a certificate from a third-party Certificate Authority (CA). This section guides you through these options.

1. Add your domain name to the `/etc/hosts` file. This guide assumes `example.com`.

    `sudo su -c "echo '127.0.0.1   example.com www.example.com' >> /etc/hosts"`{{execute}}

2. Create a new private key with OpenSSL:

    `sudo openssl genrsa -out server.key 2048`{{execute}}

    Copy this key to the `SSLCertificateKeyFile` location, overwriting the one provided by Bitnami:

    `sudo cp server.key /opt/bitnami/apache2/conf/server.key`{{execute}}

3. Restart the Apache server now:

    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}

    You will see that the server did not start. To understand why, check the error log:

    `tail /opt/bitnami/apache2/logs/error_log`{{execute}}

    You will see that the error arises because the new private key, understandably, does not match the old SSL certificate. Verify this further by executing the following commands:

    `cd /opt/bitnami/apache2/conf`{{execute}}

    `sudo openssl x509 -noout -text -in server.crt -modulus | grep Modulus`{{execute}}

    `sudo openssl rsa -noout -text -in server.key -modulus | grep Modulus`{{execute}}

    You will see that the private key fingerprint does not match the certificate fingerprint.

4. Next, create an SSL certificate that matches the new private key. This is a two-step process:

    * You will first generate a certificate request file.
    * You will then use the certificate request file to create a self-signed certificate, or give it to a third-party Certificate Authority (CA) to generate one for you.

    Begin by generating a certificate request file. Replace the `example.com` domain name in the command below with your actual domain name.

    `cd /home/bitnami`{{execute}}

    `sudo openssl req -new -key /opt/bitnami/apache2/conf/server.key -subj "/CN=example.com" -out cert.csr`{{execute}}

    If you omit the `subj` parameter, you will be prompted for information on your city, country, department and more.

    Once you generate the certificate request, you can approach a third-party Certificate Authority (CA) for verification and certificate generation. When the CA completes its checks (and probably receives payment from you), it will send your new SSL certificate to you.

    Alternatively, you can create a self-signed certificate valid for 1 year from the certificate request file:

    `sudo openssl x509 -in cert.csr -out server.crt -req -signkey /opt/bitnami/apache2/conf/server.key -days 365`{{execute}}

  To proceed further, you should have both the private key and a matching SSL certificate (either self-signed or verified by a CA).

5. Configure Apache to use the new SSL certificate. Copy the certificate to the `SSLCertificateFile` location, overwriting the one provided by Bitnami:

    `sudo cp server.crt /opt/bitnami/apache2/conf/server.crt`{{execute}}

    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}
    
    > In case you see file permission errors or warnings when restarting Apache, ensure that the certificate files are readable only by the *root* user:

    `sudo chown root:root /opt/bitnami/apache2/conf/server*`{{execute}}
    `sudo chmod 600 /opt/bitnami/apache2/conf/server*`{{execute}}


6. Verify the contents of the new certificate, in particular checking that it uses the correct domain name:

    `openssl s_client -showcerts -connect localhost:443 | more`{{execute}}
