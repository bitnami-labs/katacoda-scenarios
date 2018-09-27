Welcome to Bitnami's PHP/MySQL application deployment guide!

In this guide, you will learn, step by step, how to deploy a custom Apache/MySQL/PHP application on a Bitnami LAMP instance.

This guide uses a Bitnami LAMP image launched on a cloud instance and an example PHP/MySQL application from GitHub. The same steps apply to other Bitnami images too. Check the [Bitnami application catalog](https://bitnami.com/stacks) to quickly find and deploy other Bitnami images on the cloud.

# Assumptions and prerequisites

* You have the source code of the PHP/MySQL application you wish to deploy.
* You have the public IP address of your instance.
* You have the necessary SSH key pair to log in to your instance ([more information](https://docs.bitnami.com/general/faq/get-started/connect-ssh/)).
* You have the database `root` password for your instance ([more information](https://docs.bitnami.com/general/faq/get-started/find-credentials/)).
