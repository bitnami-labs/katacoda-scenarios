Once the certificate is working properly, it is a common practise to redirect all the traffic to HTTPS:

`curl http://localhost -L --progress-bar | grep site-title`{{execute}}

1. Add the redirection rule the main configuration file, at the default Virtual Host for HTTP:

    `sudo nano /opt/bitnami/apache2/conf/bitnami/bitnami.conf`{{execute}}
    
    <pre class="file" data-target="clipboard">
    <VirtualHost _default_:80>
      DocumentRoot "/opt/bitnami/apache2/htdocs"
      RewriteEngine On
      RewriteCond %{HTTPS} !=on
      RewriteRule ^/(.*) https://%{SERVER_NAME}/$1 [R,L]
        ...
     </VirtualHost>
    </pre>

    Once you added and saved the configuration, restart the apache server `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}.
    
2. Try to access now to the web application from the terminal:

    `curl http://localhost -L --progress-bar | grep site-title`{{execute}}
    
    The redirection should work properly as it is redirecting to 'https' and it is throwing the error because the certificate is not valid. Adding the option '--insecure' you can see the Blog title again.
    
    `curl http://localhost -L --progress-bar --insecure | grep site-title`{{execute}}

Another pretty common configuration is to redirect all the traffic from www.your-domain.com to your-domain.com (or the contrary). Lets see how this configuration would work in our testing environment.

1. Add a sample domain to the '/etc/hosts' file.

    `sudo su -c "echo '127.0.0.1   mydomain.com www.mydomain.com' >> /etc/hosts"`{{execute}}
    
    Lets check the current behavior with both domains:
    
    `curl http://www.mydomain.com -L --progress-bar --insecure | grep site-title`{{execute}}
    `curl http://mydomain.com -L --progress-bar --insecure | grep site-title`{{execute}}
    
    The response from the server contains the exact domain that you are trying to access, the only difference it is redirected to 'https'.
    
2. The server is currently redirecting all the requests to HTTPS. In this case we only need to add another redirection from 'www.mydomain.com' to 'mydomain.com'

    `sudo nano /opt/bitnami/apache2/conf/bitnami.com`{{execute}}
    
    `<VirtualHost _default_:443>
      SSLEngine on
      DocumentRoot "/opt/bitnami/apache2/htdocs"
      SSL CertificateFile "/opt/bitnami/apache2/conf/server.crt"
      SSLCertificateKeyFile "/opt/bitnami/apache2/conf/server.key"
      
      RewriteEngine On
      RewriteCond %{HTTP_HOST} ^www\.(.*)$ [NC]
      RewriteRule ^(.*)$ https://%1$1 [R=permanent,L]
      ...
    </VirtualHost>
    `
    
    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}
    
3. Check the redirection works. The response from the server should not include the 'www.' part:

    `curl http://www.mydomain.com -L --progress-bar --insecure | grep site-title`{{execute}}
    
