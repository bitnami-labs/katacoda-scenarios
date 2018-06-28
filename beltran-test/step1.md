Lets check the status of the server and the current SSL configuration.

1. Check the server status:

    `sudo /opt/bitnami/ctlscript.sh status`{{execute}}
    
    At this point all the server should be running. You can check the WordPress application via browser at the web site tab.

2. We can now check the already configured SSL certificate:

    `curl  https://localhost`{{execute}}
    
    It is configured with a self signed certificate by default. That means the browser will throw an error any time someone visit your new website. You can also see the error in the Apache error log file:
    
    `tail /opt/bitnami/apache2/logs/error_log`{{execute}}
    
    In this case you can see the server certificate does NOT include an ID which matches the server name.

2. In order to simulate a real domain, lets add a sample domain to the '/etc/hosts' file. In this example we will use "mydomain.com"

    `sudo su -c "echo '127.0.0.1   mydomain.com www.mydomain.com' >> /etc/hosts"`{{execute}}
    

3. Check the main Apache file where it is configured the certificates. You can use your favorite editor but if you are not familiar with any of them you can use 'nano'.

    `sudo apt-get install nano`{{execute}}
    
    `sudo nano /opt/bitnami/apache2/conf/bitnami/bitnami.conf`{{execute}}
    
    You can see the port is configured to 443 and the default options for the default Virtual Host. The most important parameters for SSL are the CertificateFile and the CertificateKeyFile
    
    `SSLCertificateFile "/opt/bitnami/apache2/conf/server.crt"
     SSLCertificateKeyFile "/opt/bitnami/apache2/conf/server.key"`
    
    The next examples will override the server.crt and server.key files. You can also modify the path and the names in this configuration file.
    
    
    
