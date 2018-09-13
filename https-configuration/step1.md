Begin by checking the status of the server and the current SSL configuration.

1. Check that all services are running:

    `sudo /opt/bitnami/ctlscript.sh status`{{execute}}
    
    At this point, all services should be running. Confirm this by clicking the "Web site" tab in the interactive editor on the right. This should launch a new browser window that displays the WordPress index page.

2. Check the preconfigured SSL certificate:

    `curl  https://localhost`{{execute}}
    
    The Bitnami WordPress image is configured with a self-signed certificate by default. Therefore, the user's browser will throw an error every time he or she visits the Bitnami WordPress website using an HTTPS URL. This error is visible in the Apache error log file:
    
    `tail /opt/bitnami/apache2/logs/error_log`{{execute}}
    
    You will see that the error arises because the server certificate does NOT match the server name.

3. Check the main Apache file where the SSL certificates are configured. You can use your preferred editor. This example uses `nano`.

    `sudo apt-get install nano`{{execute}}
    
    `sudo nano /opt/bitnami/apache2/conf/bitnami/bitnami.conf`{{execute}}
    
    You will see that the default SSL port is set to 443 and the default options have been applied for the virtual Host. The most important parameters in the SSL configuration are the locations of the `SSLCertificateFile` and the `SSLCertificateKeyFile`.
    
    `
    SSLCertificateFile "/opt/bitnami/apache2/conf/server.crt"
    SSLCertificateKeyFile "/opt/bitnami/apache2/conf/server.key"`

In the next steps, you will override the preconfigured SSL certificate with a new self-signed SSL certificate or a new Let's Encrypt SSL certificate generated specifically for your domain.