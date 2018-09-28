The next step is to create a MySQL database and user account for the application, then add the necessary credentials to the application source code. This step will create a new MySQL user account with the following parameters:

* Permitted host: `localhost`
* Username: `myapp`
* Password: `5ecr3tpa55`
* Database name: `test`

Before proceeding, make sure that you have the database `root` password. You can obtain the password using the following command: 

`cat ~\bitnami_credentials`{{execute}}

1. Use the MySQL command-line client to import the application database using the command below. Enter the database `root` password when prompted:

    `cd /opt/bitnami/apps/myapp/htdocs`{{execute}}
    
    `mysql -u root -p < database.sql`{{execute}}
    
    This operation will create a new database named `test` with all the required data for the application.

2. Create a new MySQL database user with privileges to access only the new database. This is a recommended security practice to reduce the risk of unauthorized database access or damage.

    `mysql -u root -p -e "GRANT ALL ON test.* To 'myapp'@'localhost' IDENTIFIED BY '5ecr3tpa55';"`{{execute}}

    This operation will create a new database user named `myapp` with password `5ecr3tpa55` and full privileges to the `test` database. This user will only be able to access the `test` database from the same instance  (`localhost`).

3. Update lines 16-19 of the application configuration file with the database access credentials shown above and save the changes:

    `sudo nano /opt/bitnami/apps/myapp/htdocs/config.php`{{execute}}
    
In the next step, you will modify the Apache configuration.