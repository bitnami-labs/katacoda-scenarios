Lets try to create a new certificate on our own and replace the default one. This is required when you need to create a real SSL certificate to associate with your domains.

1. We need to create a new private key with OpenSSL:

    `genrsa -out server.key 2048`{{execute}}
    
    Then copy it to the Apache server default location:
    
    `sudo cp server.key /opt/bitnami/apache/conf/server.key`{{execute}}
    
2. You can try to restart the server now and check if it is able to start:

    `sudo /opt/bitnami/ctscript.sh restart apache`{{execute}}
    
    It was not possible to start the server, lets check the exact error in the log:
    
    `tail /opt/bitnami/apache2/logs/error.log`{{execute}}
    
    The issue is the key and the cert does not match. It is also possible to check if they match with the following commands:
    
    `cd /opt/bitnami/apache2/conf`{{execute}}
    `sudo openssl x509 -noout -text -in server.crt -modulus | grep Modulus`{{execute}}
    `sudo openssl x509 -noout -text -in server.key -modulus | grep Modulus`{{execute}}
    
    
3. Lets create a new certificate that matches with the SSL key we just generated. You should use the domain name in the "Common Name" option.

    `cd /home/bitnami`{{execute}}
    `openssl req -new -key server.key -out cert.csr`{{execute}}
    
    Once you generated the Certificate request, you should to the certificate authority. When the certificate authority completes their checks (and probably received payment from you), they will hand over your new certificate to you. In our example we will create a self-signed certificate valid for 1 year.
    
    `openssl x509 -in cert.csr -out server.crt -req -signkey server.key -days 365`
    
4. Now we have the certificate already created so we can configure Apache to use it:

    `sudo cp sever.crt /opt/bitnami/apache/conf/server.crt`{{execute}}
    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}
    
    
