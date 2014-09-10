#
# Cookbook Name:: hadoop::
# Recipe:: namenode
#
# License: MIT http://opensource.org/licenses/MIT
#
include_recipe 'hadoop::install'


#Create namenode directory
directory node[:hadoop][:namenode][:name_dir] do
  mode 0775
  owner node[:hadoop][:user]
  group node[:hadoop][:group]
  recursive true
  action :create
end

#Format namenode if it has not been formatted 
bash 'Initialize required directories' do
  cwd '/usr/local/hadoop'
  user node[:hadoop][:user]
  code <<-EOH
    ./bin/hdfs namenode -format
  EOH
  not_if { ::File.exists?("#{node[:hadoop][:namenode][:name_dir]}/current/VERSION") }
end


#Create namenode service script

template '/etc/init.d/namenode' do
  mode '0755'
  source 'hdfs-initd-template.erb'
  variables({
    :service_name => 'namenode',
    :service_cmd => '/usr/local/hadoop/bin/hdfs-configured',
  })
end

#Start or restart namenode service
service "namenode" do
  supports :status => true, :restart => true
  action [:enable, :start]
  subscribes :reload, "template[core-site.xml]", :delayed
  subscribes :reload, "template[hdfs-site.xml]", :delayed
end