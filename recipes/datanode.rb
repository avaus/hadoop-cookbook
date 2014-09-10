#
# Cookbook Name:: hadoop::
# Recipe:: datanode
#
# License: MIT http://opensource.org/licenses/MIT
#
include_recipe 'hadoop::install'



directory node[:hadoop][:datanode][:data_dir] do
  mode 0775
  owner node[:hadoop][:user]
  group node[:hadoop][:group]
  recursive true
  action :create
end


template '/etc/init.d/datanode' do
  mode '0755'
  source 'hdfs-initd-template.erb'
  variables({
    :service_name => 'datanode',
    :service_cmd => '/usr/local/hadoop/bin/hdfs-configured',
  })
end

service "datanode" do
  supports :status => true, :restart => true
  action [:enable, :start]
  subscribes :reload, "template[core-site.xml]", :delayed
  subscribes :reload, "template[hdfs-site.xml]", :delayed
end