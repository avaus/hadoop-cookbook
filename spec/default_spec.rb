require 'chefspec'

describe 'hadoop::default' do

  chef_run = ChefSpec::ChefRunner.new(platform:'centos', version:'6.4') do |node|
    #node.set['my_attribute'] = 'bar'
  end
  chef_run.converge 'hadoop::default'
  
  it 'include hadoop install' do
    expect(chef_run).to include_recipe 'hadoop::install' # ~FC007
  end
end
