#
# Cookbook Name:: wordpress
# Recipe:: default
#
# Copyright 2014, copyright-entity
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "apache2"
include_recipe "mysql::client"
include_recipe "mysql::server"
include_recipe "php"
include_recipe "php::module_mysql"
include_recipe "apache2::mod_php5"
include_recipe "database::mysql"

apache_site "default" do
  enable true
end

mysql_pass = node['wordpress']['mysql']['server_root_password']

file "/root/.my.cnf" do
  owner "root"
  group "root"
  mode 0644
  action :create
  content "[client]\nuser=root\npassword=#{mysql_pass}\npass=#{mysql_pass}"
end
	
service "apache2" do
  supports :restart => true, :start => true, :stop => true, :reload => true   
  action :restart
end

file "/var/www/html/index.html" do
  owner "apache"
  group "apache"
  mode 00644
  action :create
  content "<html><body><h1>WORKS WORKS!</h1><h2><a href='info.php'>phpinfo();</a><br /><a href='wordpress'>Wordpress</a></body></html>"
end

file "/var/www/html/info.php" do
  owner "apache"
  group "apache"
  mode 00644
  action :create
  content "<? phpinfo(); ?>"
end


database_name = node['wordpress']['database']

mysql_database "#{database_name}" do
  connection ({:host => 'localhost', :username => 'root', :password => node['wordpress']['mysql']['server_root_password']})
  action :create
end

mysql_database_user node['wordpress']['db_username'] do
  connection ({:host => 'localhost', :username => 'root', :password => node['wordpress']['mysql']['server_root_password']})
  password node['wordpress']['db_password']
  database_name node['wordpress']['database']
  privileges [:select,:update,:insert,:create,:delete]
  action :grant
end

database_user = node['wordpress']['db_username']
database_pass = node['wordpress']['db_password']

bash "untar-wordpress" do
  code <<-EOH
    cd /var/www/html/;
    rm -rf wordpress;
    wget -c http://wordpress.org/latest.tar.gz;
    tar xvf latest.tar.gz;   
    rm -rf latest.tar.gz;
    mv wp-config-sample.php wp-config.php;
    chown apache:apache -R wordpress/;
    mv wordpress/wp-config-sample.php wordpress/wp-config.php;
    sed -i "s/database_name_here/#{database_name}/g" wordpress/wp-config.php;
    sed -i "s/username_here/#{database_user}/g" wordpress/wp-config.php;
    sed -i "s/password_here/#{database_pass}/g" wordpress/wp-config.php;    
    /etc/init.d/mysqld stop
    /etc/init.d/mysqld start
  EOH
end
