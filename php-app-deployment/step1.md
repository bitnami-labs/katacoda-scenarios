This guide uses a simple PHP/MySQL example application from GitHub. However, the general principles described will apply to any custom PHP/MySQL application.

Begin by installing Git and downloading the application source code from GitHub. If your application source code is stored elsewhere, you can also transfer it to the instance using SFTP, email or any other transfer mechanism.

1. Check that all services are running:

    `sudo /opt/bitnami/ctlscript.sh status`{{execute}}

    At this point, all services should be running. Confirm this by clicking the "Web site" tab in the interactive editor on the right. This should launch a new browser window that displays the LAMP index page.

2. Install Git and a text editor. This example uses `nano` but you can use any editor that you prefer:

    `sudo apt-get install git`{{execute}}

    `sudo apt-get install nano`{{execute}}
    
3. Create the necessary directory structure for the application. In this guide, the example application will be stored in the `/opt/bitnami/apps/myapp` directory.

    `sudo mkdir /opt/bitnami/apps/myapp`{{execute}}
    
    `sudo mkdir /opt/bitnami/apps/myapp/htdocs`{{execute}}
    
    `sudo mkdir /opt/bitnami/apps/myapp/conf`{{execute}}

4. Change to the application directory and clone the application source code repository:

    `cd /opt/bitnami/apps/myapp/htdocs/`{{execute}}

    `sudo git clone https://github.com/chapagain/crud-php-simple.git .`{{execute}}

In the next step, you will create a MySQL database and user account for the application, and update the application source code with the necessary access credentials.