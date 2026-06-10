With these Ansible playbooks, you can manage WordPress sites using WordPress WP-CLI.

The playbooks can:

Install and remove plugins
Configure WordPress parameters
Automatically create a backup before updates
Restore websites from backups
Migrate WordPress sites between servers

SSH access to the target server is required.

The rclone package must be installed and configured to connect to a cloud storage service. Rclone supports more than 70 storage providers.

The scripts do not contain passwords. Database connection parameters are detected automatically from the WordPress configuration.
Web service host based variables are group variables: inventory/group_vars/

example :
ansible-playbook -i inventory/hosts.ini update_plugins.yml --tags "backup"

Yes, the scripts still need improvement and some additional setup.

Please let me know if you find them useful or if you have any suggestions for improvement. Your feedback is greatly appreciated.


