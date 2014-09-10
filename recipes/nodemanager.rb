#
# Cookbook Name:: hadoop::
# Recipe:: nodemanager
#
# License: MIT http://opensource.org/licenses/MIT
#
include_recipe 'hadoop::install'


#Create nodemanager service script
template '/etc/init.d/nodemanager' do
  mode '0755'
  source 'hdfs-initd-template.erb'
  variables({
    :service_name => 'nodemanager',
    :service_cmd => '/usr/local/hadoop/bin/yarn-configured'
  })
end

#Start or restart nodemanager service
service "nodemanager" do
  supports :status => true, :start => true, :stop => true, :restart => true
  action [:enable, :start]
  subscribes :reload, "template[yarn-site.xml]", :delayed
end