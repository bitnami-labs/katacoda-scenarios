Once the certificate is working properly, you can implement some common redirections.

## Redirect HTTP requests to HTTPS requests

A common practice is to redirect all HTTP traffic to the HTTPS URL. To do this, follow the steps below:

1. Add the redirection rule to the main configuration file, in the block for the default HTTP virtual host:

    `sudo nano /opt/bitnami/apache2/conf/bitnami/bitnami.conf`{{execute}}

    Paste the following block into the `<VirtualHost _default_:80>` section:

    <pre class="file" data-target="clipboard">
RewriteEngine On
RewriteCond %{HTTPS} !=on
RewriteRule ^/(.*) https://%{SERVER_NAME}/$1 [R,L]
    </pre>

    Once you have added and saved the configuration, restart the Apache server

    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}.

2. Test the redirection, by accessing WordPress using its HTTP URL. Replace the `example.com` domain name in the command below with your actual domain name.

    `curl http://example.com -L --progress-bar | grep "base href"`{{execute}}

    You will see that your request for the HTTP URL is automatically redirected to the HTTPS URL. However, if you used a self-signed certificate, you will instead an error because the SSL certificate is self-signed and not authenticated by a third-party certificate authority. In this case, try again, adding the `--insecure` option to bypass the self-signed certificate warning, and this time you should be redirected automatically to the HTTPS URL without any further errors.

    `curl http://example.com -L --progress-bar --insecure | grep "base href"`{{execute}}

## Redirect requests from www.example.com to example.com

Another popular configuration is to redirect all requests for `www.example.com` to `example.com`. To do this, follow the steps below:

1. Check the current behavior using both domains. Replace the `example.com` domain name in the command below with your actual domain name.

    `curl http://www.example.com -L --progress-bar --insecure | grep "base href"`{{execute}}

    `curl http://example.com -L --progress-bar --insecure | grep "base href"`{{execute}}

    You will see that the response from the server in each case contains the exact domain that you are trying to access, the only difference being that one of them is being redirected to the corresponding HTTPS URL.

2. Add the redirection rule from `www.example.com` to `example.com` to the main configuration file, in the block for the default HTTP virtual host:

    `sudo nano /opt/bitnami/apache2/conf/bitnami/bitnami.conf`{{execute}}

    Paste the following block into the `<VirtualHost _default_:80>` section:

    <pre class="file" data-target="clipboard">
RewriteEngine On
RewriteCond %{HTTP_HOST} ^www\.(.*)$ [NC]
RewriteRule ^(.*)$ https://%1$1 [R=permanent,L]
    </pre>

    > In case you have also defined a redirection for HTTP URLs to HTTPS URLs, as shown in the previous section, ensure that the above rewrite rules appear before that redirection.

    Once you have added and saved the configuration, restart the Apache server

    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}.

3. Test the redirection, by accessing WordPress using its HTTP URL. Replace the `example.com` domain name in the command below with your actual domain name.

    `curl http://www.example.com -L --progress-bar --insecure | grep "base href"`{{execute}}

  You will see that although you have requested the domain name using the `www` prefix, the response from the server no longer includes this prefix.