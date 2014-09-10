#
# Cookbook Name:: hadoop
# Recipe:: install
#
# License: MIT http://opensource.org/licenses/MIT
#
include_recipe 'apt'
include_recipe 'java::default'


#Create user group
group node[:hadoop][:group] do
  action :create
  members node[:hadoop][:users]
end

#Create user
user node[:hadoop][:user] do
  gid node[:hadoop][:group]
  shell '/bin/bash'
end

#Create home directory for hadoop user
directory '/home/hadoop' do
  mode 0775
  owner node[:hadoop][:user]
  group node[:hadoop][:group]
  recursive true
  action :create
end

#Create temp directory for hadoop
directory node[:hadoop][:tmp_dir] do
  mode 0775
  owner node[:hadoop][:user]
  group node[:hadoop][:group]
  recursive true
  action :create
end



#Download and install hadoop
ark 'hadoop' do
  owner node[:hadoop][:user]
  url "#{node[:hadoop][:mirror]}/hadoop-#{node[:hadoop][:version]}/hadoop-#{node[:hadoop][:version]}.tar.gz"
  append_env_path true
end


#Create configuration files from templates
template 'hadoop-profile-sh' do
  path '/etc/profile.d/hadoop.sh'
  source 'hadoop-profile-sh.erb'
end

template 'core-site.xml' do
  path '/usr/local/hadoop/etc/hadoop/core-site.xml'
  source 'core-site.xml.erb'
end

template 'hdfs-site.xml' do
  path '/usr/local/hadoop/etc/hadoop/hdfs-site.xml'
  source 'hdfs-site.xml.erb'
end

template 'yarn-site.xml' do
  path '/usr/local/hadoop/etc/hadoop/yarn-site.xml'
  source 'yarn-site.xml.erb'
end

template 'capacity-scheduler.xml' do
  path '/usr/local/hadoop/etc/hadoop/capacity-scheduler.xml'
  source 'capacity-scheduler.xml.erb'
end


template '/usr/local/hadoop/bin/hdfs-configured' do
  mode '0755'
  owner node[:hadoop][:user]
  group node[:hadoop][:user]
  source 'configured-start.sh.erb'
  variables({
    :service_name => 'hdfs',
    :cmd => '/usr/local/hadoop/bin/hdfs'
  })
end

template '/usr/local/hadoop/bin/yarn-configured' do
  mode '0755'
  owner node[:hadoop][:user]
  group node[:hadoop][:user]
  source 'configured-start.sh.erb'
  variables({
    :service_name => 'yarn',
    :cmd => '/usr/local/hadoop/bin/yarn'
  })
end
