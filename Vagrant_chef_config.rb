# 
# Load cookbooks from /cookbook_deps and /cookbooks in the VM
# 
::Chef::Config.from_string("cookbook_path ['/cookbook_deps', '/berks-cookbooks']", "vagrant_chef_config.rb")