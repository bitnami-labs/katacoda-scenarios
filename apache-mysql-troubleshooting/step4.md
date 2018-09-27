As part of the troubleshooting process, it is often necessary to make changes to system configuration and files. Bitnami recommends that you always back up your data before making any such changes.

## Backup

To back up all your MySQL databases, use the command below. Enter the database *root* password when prompted.

`cd /home/bitnami`{{execute}}

`mysqldump -A -u root -p > backup.sql`{{execute}}

> This operation could take some time depending on the database sizes.

This operation will create a single file containing the data from all your MySQL databases. Once the operation is complete, download the file to your local system and store it carefully.

## Restore

To restore the contents of the backup file, use the command below. Enter the database *root* password when prompted.

`cd /home/bitnami`{{execute}}

`mysql -u root -p < backup.sql`{{execute}}

> This operation could take some time depending on the database sizes.