Lets check the status of the server and the current SSL configuration.

1. Check the server status:

    `sudo /opt/bitnami/ctscript.sh status`{{execute}}
    
    At this point all the server should be running. You can check the WordPress application via browser at the web site tab.

2. We can now check the already configured SSL certificate:

    `curl  https://localhost`{{execute}}
    
    It is configured with a self signed certificate by default. That means the browser will throw an error any time someone visit your new website. You can also see the error in the Apache error log file:
    
    `tail /opt/bitnami/apache2/logs/error.log`
    
    In this case you can see the server certificate does NOT include an ID which matches the server name.
    
    
    
