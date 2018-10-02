The final step is to create the necessary Apache configuration files for the application.

1. Create the `/opt/bitnami/apps/myapp/conf/httpd-prefix.conf` file:

    `sudo nano /opt/bitnami/apps/myapp/conf/httpd-prefix.conf`{{execute}}

    Add the lines below to it:

    ```
    Alias /myapp/ "/opt/bitnami/apps/myapp/htdocs/"
    Alias /myapp "/opt/bitnami/apps/myapp/htdocs/"
    Include "/opt/bitnami/apps/myapp/conf/httpd-app.conf"
    ```

2. Create the `/opt/bitnami/apps/myapp/conf/httpd-app.conf` file:

    `sudo nano /opt/bitnami/apps/myapp/conf/httpd-app.conf`{{execute}}

    Add the lines below to it:
    
    `\<Directory /opt/bitnami/apps/myapp/htdocs/\>
        Options +FollowSymLinks
        AllowOverride None
        <IfVersion < 2.3 >
        Order allow,deny
        Allow from all
        </IfVersion>
        <IfVersion >= 2.3>
        Require all granted
        </IfVersion>
    \</Directory\>`

    > NOTE: If your application uses `.htaccess` files, you should change the `AllowOverride None` option to `AllowOverride All`.

3. Edit the main Apache configuration file:

    `sudo nano /opt/bitnami/apache2/conf/bitnami/bitnami-apps-prefix.conf`{{execute}}
    
    Add the lines below to it:

    `Include "/opt/bitnami/apps/myapp/conf/httpd-prefix.conf"`{{execute}}

4. Restart the Apache server:

    `sudo /opt/bitnami/ctlscript.sh restart apache`{{execute}}
