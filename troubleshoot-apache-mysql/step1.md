The PHP script in this example should connect to the MySQL database, retrieve a list of records and display them as a Web page. Use the command below to access it:

`curl http://localhost/example.php`{{execute}}

As you can see, there is no output displayed. This implies that there was an error in the script. To locate and resolve the error, follow the steps below:

1. Check the Apache error log:

    `sudo tail /opt/bitnami/apache2/logs/error_log`{{execute}}

    You will see that the source of the error is a syntax error on line 6 of the script.

2. Check the PHP script. You can use your preferred editor. This example uses `nano`.

    `sudo apt-get install nano`{{execute}}

    `sudo nano /opt/bitnami/apache2/htdocs/example.php`{{execute}}

    You will see that there is a missing semi-colon at the end of line 5. Add this to resolve the syntax error and save the file. 

Continue to the next step to see if this resolves the error.