#
# Cookbook Name:: hadoop::
# Recipe:: resourcemanager
#
# License: MIT http://opensource.org/licenses/MIT
#
include_recipe 'hadoop::install'


#create resourcemanager service script
template '/etc/init.d/resourcemanager' do
  mode '0755'
  source 'hdfs-initd-template.erb'
  variables({
    :service_name => 'resourcemanager',
    :service_cmd => '/usr/local/hadoop/bin/yarn-configured'
  })
end

#Start or restart resourcemanager service
service "resourcemanager" do
  supports :status => true, :restart => true
  action [:enable, :start]
  subscribes :reload, "template[yarn-site.xml]", :delayed
end