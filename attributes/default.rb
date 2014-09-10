
default[:hadoop][:version] = '2.4.0'

# from http://www.apache.org/dyn/closer.cgi/hadoop/common/
default[:hadoop][:mirror] = 'http://www.nic.funet.fi/pub/mirrors/apache.org/hadoop/common'

default[:hadoop][:user] = 'hadoop'
default[:hadoop][:group] = 'hadoop'
default[:hadoop][:supergroup] = 'hadoop'

# Extra users added to hadoop group
default[:hadoop][:users] = []

default[:hadoop][:install_dir] = '/usr/local'
default[:hadoop][:tmp_dir] = '/opt/hadoop/tmp'

default[:hadoop][:namenode][:host] = 'localhost'
default[:hadoop][:namenode][:port] = '54310'
default[:hadoop][:datanode][:data_dir] = '/opt/hadoop/tmp/datanode'
default[:hadoop][:namenode][:name_dir] = '/opt/hadoop/tmp/namenode'

default[:hadoop][:tracker] = 'localhost:54311'

default[:hadoop][:resourcemanager][:host] = 'localhost'

# Configurations
default[:hadoop][:webhdfs] = false
default[:hadoop][:permissions] = true
default[:hadoop][:permitted_hosts] = ""
default[:hadoop][:ip_hostname_check] = true
default[:hadoop][:rpc_bind_host] = nil

default[:hadoop][:nodemanager][:address] = '0.0.0.0:0'

# Extra configs to core-site.xml
default[:hadoop][:core_configs] = {}
