name             'hadoop'
maintainer       'Avaus Consulting'
maintainer_email 'erno.aapa@avaus.fi'
license          'MIT'
description      'Installs/Configures hadoop'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'


%w{ ubuntu }.each do |os|
  supports os
end

# Cookbook dependencies
%w{ apt java ark }.each do |cb|
  depends cb
end
