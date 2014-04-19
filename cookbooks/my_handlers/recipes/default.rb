#
# Cookbook Name:: my_handlers
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

include_recipe 'chef_handler'

chef_gem "chef-irc-snitch"

chef_handler 'Chef::Handler::IRCSnitch' do
  action :enable
  arguments :irc_uri => "irc://balala:rackspace@chat.freenode.net:6667/#baliochat"
  source File.join(Gem::Specification.find{|s| s.name == 'chef-irc-snitch'}.gem_dir,
                   'lib',
                   'chef-irc.snitch.rb')
end
