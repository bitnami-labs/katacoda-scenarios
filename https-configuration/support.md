If you still need help, use the Bitnami Support Tool to gather relevant information from your instance. The Bitnami Support Team uses this information to help you debug your issue and solve your problem.

The Bitnami Support Tool is included in every Bitnami Stack released since 1 November 2017. It retrieves the following data:

* Basic information about the stack and its host system such as:
  * OS family and distribution
  * Instance IP address, hostname, CPU, RAM, swap memory and free disk space
  * Stack name, version, type and platform
  * Stack installation directory and user

* Configuration and log files

> IMPORTANT: Some configuration and log files can contain credentials or other critical information. The Bitnami Support Tool skips those files to guarantee your security and privacy.

Run the Bitnami Support Tool as shown below:

`sudo /opt/bitnami/bnsupport-tool`{{execute}}

Go ahead and check for new updates, then enter the directory where your Bitnami stack was installed (this  is */opt/bitnami* by default). The tool displays the information that will be shared with the Bitnami Support Team. Please review it and let a Bitnami support agent know if you do not agree to share some of the information.

The tool will upload the information collected to a secure bucket, which is only accessible by Bitnami Support agents, and print a code. Share this code with the agent in your Bitnami Support ticket.