default['wordpress']['mysql']['service_name'] = 'default'
default['wordpress']['mysql']['server_root_password'] = 'ilikerandompasswords'
default['wordpress']['mysql']['server_debian_password'] = 'postinstallscriptsarestupid'
default['wordpress']['mysql']['data_dir'] = '/var/lib/mysql'
default['wordpress']['mysql']['port'] = '3306'

### used in grants.sql
default['wordpress']['mysql']['allow_remote_root'] = false
default['wordpress']['mysql']['remove_anonymous_users'] = true
default['wordpress']['mysql']['root_network_acl'] = nil

### database details
default['wordpress']['database'] = 'wordpress'
default['wordpress']['db_username'] = 'wp_user'
default['wordpress']['db_password'] = 'wp_rackspace'
