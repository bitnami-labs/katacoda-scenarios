Now that you have understood the Apache SSL configuration, this section guides you through the process of replacing the default SSL certificate with a new self-signed certificate that matches your domain name.

1. Add your domain name to the `/etc/hosts` file. This guide uses `example.com`.

    `sudo su -c "echo '127.0.0.1   example.com www.example.com' >> /etc/hosts"`{{execute}}

    Lets try to create a new certificate on your own and replacing the default one. This is required when you need to create a real SSL certificate to associate it with your domains.

2. Create a new private key with OpenSSL:

    `openssl genrsa -out server.key 2048`{{execute}}
    
    Copy this key to the `CertificateKeyFile` location, overwriting the one provided by Bitnami:
    
    `sudo cp server.key /opt/bitnami/apache2/conf/server.key`{{execute}}
    
3. Restart the Apache server now:

    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}
    
    You will see that it was not possible to start the server. To understand why, check the error log:
    
    `tail /opt/bitnami/apache2/logs/error_log`{{execute}}
    
    You will see that the error arises because the new private key, understandably, does not match the old SSL certificate. Verify this further by executing the following commands:
    
    `cd /opt/bitnami/apache2/conf`{{execute}}
    
    `sudo openssl x509 -noout -text -in server.crt -modulus | grep Modulus`{{execute}}
    
    `sudo openssl rsa -noout -text -in server.key -modulus | grep Modulus`{{execute}}

    You will see that the private key fingerprint does not match the certificate fingerprint.

4. The next step is to create a new SSL certificate that matches the new private key. This is a two-step process:

    You will first generate a certificate request file.
    You will then use the certificate request file to create a self-signed certificate, or give it to a third-party certificate authority to generate one for you.

You should use the domain name in the "Common Name" option. This example uses `example.com`.

    If you do not specify the "subj" option, the tool will allow you to provide all the certificate data like City, Country, Department and more.

    `cd /home/bitnami`{{execute}}
    
    `openssl req -new -key server.key -subj "/CN=mydomain.com" -out cert.csr`{{execute}}
    
    Once you generated the Certificate request, you should to the certificate authority. When the certificate authority completes their checks (and probably received payment from you), they will hand over your new certificate to you. 
    
    In our example we will create a self-signed certificate valid for 1 year.
    
    `openssl x509 -in cert.csr -out server.crt -req -signkey server.key -days 365`{{execute}}
    
4. Now we have the certificate already created so we can configure Apache to use it:

    `sudo cp server.crt /opt/bitnami/apache2/conf/server.crt`{{execute}}
    
    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}
    
5. Verify the new certificate in Apache has the correct content:

    `openssl s_client -showcerts -connect localhost:443 | more`{{execute}}
    
