Lets check the status of the server and the current SSL configuration.

1. Check first that all services are running:

    `sudo /opt/bitnami/ctlscript.sh status`{{execute}}
    
    At this point all services should be running. You can check the WordPress application by clicking the via browser at the web site tab in the right side of the screen.

2. Check the already configured SSL certificate:

    `curl  https://localhost`{{execute}}
    
    The image is configured with a self signed certificate by default. This means that the browser will throw an error any time someone visit your new website. You can also see the error in the Apache error log file:
    
    `tail /opt/bitnami/apache2/logs/error_log`{{execute}}
    
    In that case, you can see that the server certificate does NOT include an ID which matches the server name.

2. In order to simulate a real domain, lets add a sample domain to the '/etc/hosts' file. In this example we will use "mydomain.com"

    `sudo su -c "echo '127.0.0.1   mydomain.com www.mydomain.com' >> /etc/hosts"`{{execute}}
    

3. Check the main Apache file where the certificates are configured the certificates. You can use your preferred editor. This examples uses 'nano'.

    `sudo apt-get install nano`{{execute}}
    
    `sudo nano /opt/bitnami/apache2/conf/bitnami/bitnami.conf`{{execute}}
    
    The port is configured to 443 and the default options for the default Virtual Host. The most important parameters for SSL are the CertificateFile and the CertificateKeyFile.
    
    `SSLCertificateFile "/opt/bitnami/apache2/conf/server.crt"
     SSLCertificateKeyFile "/opt/bitnami/apache2/conf/server.key"`
    
    Next examples will override the server.crt and server.key files. You can also modify the path and the names of the certificate files in this configuration file.
    
    
    
