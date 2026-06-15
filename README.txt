With these Ansible playbooks, you can manage WordPress sites using WordPress WP-CLI.

The playbooks can:

Install and remove plugins
Configure WordPress parameters
Automatically create a backup before updates
Restore websites from backups
Migrate WordPress sites between servers

SSH access to the target server is required.

The rclone package must be installed and configured to connect to a cloud storage service if you want to store backups in the cloud. Rclone supports more than 70 storage providers.

The scripts do not contain passwords. Database connection parameters are detected automatically from the WordPress configuration.
Web service host based variables are group variables: inventory/group_vars/

example :
ansible-playbook -i inventory/hosts.ini update_plugins.yml --tags "backup"

A little hint: if you are using WSL on Windows to run Ansible locally, you can copy files directly from cloud storage to Windows using rclone:

rclone copy google:backups /mnt/c/Backups/ --progress

This command copies files from the google:backups remote to the C:\Backups directory on Windows.

About security: If you lose your private key, you can generate a new one using your Estonian ID card or Mobile-ID. The website owner can remove your old ID and public key. In my opinion, this is safe for both parties. This script does not save any passwords. If you need to manage passwords or other sensitive information, use Ansible Vault. You can upload your private key and Ansible Vault file to the Bitwarden.eu service, which can be protected with a YubiKey. You can also manage secrets in Bitwarden directly from Ansible, but I think that using Ansible Vault is secure enough.
Just upload your Ansible Vault file to vault.bitwarden.eu and download it when needed.


Yes, the scripts still need improvement and some additional setup.
Please let me know if you find them useful or if you have any suggestions for improvement. Your feedback is greatly appreciated.





