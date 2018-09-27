Welcome to Bitnami's Apache and MySQL troubleshooting guide!

In this guide, you will learn, step by step, how to troubleshoot and resolve Apache and MySQL problems with your Bitnami applications.

This guide uses a Bitnami LAMP image containing a PHP script that is deliberately broken. Over the next few steps, you will follow some basic troubleshooting steps to identify the errors and resolve them to produce a functioning result. Although this is a contrived example, the principles shown here can be applied to debug Apache and MySQL issues on any Bitnami image. 

# Assumptions and prerequisites

* You have the public IP address of your instance.
* You have the necessary SSH key pair to log in to your instance ([more information](https://docs.bitnami.com/general/faq/get-started/connect-ssh/)).
* You have the database *root* password for your instance ([more information](https://docs.bitnami.com/general/faq/get-started/find-credentials/)).
