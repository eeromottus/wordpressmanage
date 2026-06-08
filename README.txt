NB!
You need to set ssh connections to servers. It is possible. 
Without tag makes backup and wordress update
You can exclude plugins with ansible variable excluded_plugins.
Web service host based variables are group variables: inventory/group_vars/
ansible-playbook -i inventory/hosts.ini update_plugins.yml --tags "backup"


