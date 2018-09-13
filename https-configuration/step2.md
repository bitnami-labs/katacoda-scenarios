Lets try to create a new certificate on your own and replacing the default one. This is required when you need to create a real SSL certificate to associate it with your domains.

1. You need to create a new private key with OpenSSL:

    `openssl genrsa -out server.key 2048`{{execute}}
    
    Copy it to the Apache server default location:
    
    `sudo cp server.key /opt/bitnami/apache2/conf/server.key`{{execute}}
    
2. Try to restart the server now and check if it is able to start:

    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}
    
    It was not possible to start the server, lets check the exact error in the log:
    
    `tail /opt/bitnami/apache2/logs/error_log`{{execute}}
    
    As you can see, the issue is the key and the cert does not match. You can also check the issue by executing the following commands:
    
    `cd /opt/bitnami/apache2/conf`{{execute}}
    
    `sudo openssl x509 -noout -text -in server.crt -modulus | grep Modulus`{{execute}}
    
    `sudo openssl rsa -noout -text -in server.key -modulus | grep Modulus`{{execute}}
    
    
3. Lets create a new certificate that matches with the SSL key we just generated. You should use the domain name in the "Common Name" option. In this example we will use "mydomain.com".

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
    
