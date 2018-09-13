Now that you have understood the Apache SSL configuration, this section guides you through the process of replacing the default SSL certificate with a new self-signed certificate that matches your domain name.

1. Add your domain name to the `/etc/hosts` file. This guide assumes `example.com`.

    `sudo su -c "echo '127.0.0.1   example.com www.example.com' >> /etc/hosts"`{{execute}}

    Lets try to create a new certificate on your own and replacing the default one. This is required when you need to create a real SSL certificate to associate it with your domains.

2. Create a new private key with OpenSSL:

    `openssl genrsa -out server.key 2048`{{execute}}
    
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
    * You will then use the certificate request file to create a self-signed certificate, or give it to a third-party certificate authority to generate one for you.

    Begin by generating a certificate request file. Replace the `example.com` domain name in the command below with your actual domain name.
  
    `cd /home/bitnami`{{execute}}
    
    `openssl req -new -key server.key -subj "/CN=mydomain.com" -out cert.csr`{{execute}}

    If you omit the `subj` parameter, you will be prompted for information on your city, country, department and more.
    
    Once you generate the certificate request, you can approach a third-party certificate authority for verification and certificate generation. When the certificate authority completes its checks (and probably receives payment from you), it will send your new SSL certificate to you. 
    
    Alternatively, you can create a self-signed certificate valid for 1 year from the certificate request file:
    
    `openssl x509 -in cert.csr -out server.crt -req -signkey server.key -days 365`{{execute}}

  At the end of this step, you will have both the private key and a matching SSL certificate (either self-signed or verified by a certificate authority.
  
5. Configure Apache to use the new SSL certificate. Copy the certificate to the `SSLCertificateFile` location, overwriting the one provided by Bitnami:

    `sudo cp server.crt /opt/bitnami/apache2/conf/server.crt`{{execute}}
    
    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}
    
6. Verify the new certificate:

    `openssl s_client -showcerts -connect localhost:443 | more`{{execute}}
   