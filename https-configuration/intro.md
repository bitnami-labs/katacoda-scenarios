Welcome to Bitnami's Apache SSL troubleshooting guide!

In this guide, you will learn, step by step, how to troubleshoot SSL issues with your Apache server configuration and how to create redirections.

This guide uses a Bitnami WordPress image launched on a cloud instance to illustrate the process of configuring and troubleshooting SSL certificates. The same steps apply to other Bitnami images too. Check the [Bitnami application catalog](https://bitnami.com/stacks) to quickly find and deploy any Bitnami application on the cloud.

# Assumptions and prerequisites

* You have the public IP address of your instance.
* You have the necessary SSH key pair to log in to your instance.
* You have configured your domain's DNS settings such that your domain name, with and without the `www` prefix, points to the public IP address of your instance.
