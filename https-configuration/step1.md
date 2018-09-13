Begin by checking the status of the server and the current SSL configuration.

1. Check that all services are running:

    `sudo /opt/bitnami/ctlscript.sh status`{{execute}}
    
    At this point, all services should be running. Confirm this by clicking the "Web site" tab in the interactive editor on the right. This should launch a new browser window that displays the WordPress indec page.

2. Check the preconfigured SSL certificate:

    `curl  https://localhost`{{execute}}
    
    The Bitnami WordPress image is configured with a self-signed certificate by default. Therefore, the user's browser will throw an error every time he or she visits the Bitnami WordPress website using an HTTPS URL. This error is visible in the Apache error log file:
    
    `tail /opt/bitnami/apache2/logs/error_log`{{execute}}
    
    You can see that the server certificate does NOT include an ID which matches the server name.

3. To simulate a real domain, add a sample domain to the `/etc/hosts` file. For this guide, use `example.com`.

    `sudo su -c "echo '127.0.0.1   example.com www.example.com' >> /etc/hosts"`{{execute}}

3. Check the main Apache file where the certificates are configured the certificates. You can use your preferred editor. This examples uses 'nano'.

    `sudo apt-get install nano`{{execute}}
    
    `sudo nano /opt/bitnami/apache2/conf/bitnami/bitnami.conf`{{execute}}
    
    The port is configured to 443 and the default options for the default Virtual Host. The most important parameters for SSL are the CertificateFile and the CertificateKeyFile.
    
    `SSLCertificateFile "/opt/bitnami/apache2/conf/server.crt"
     SSLCertificateKeyFile "/opt/bitnami/apache2/conf/server.key"`
    
    Next examples will override the server.crt and server.key files. You can also modify the path and the names of the certificate files in this configuration file.
    
    
    