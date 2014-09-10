require 'chefspec'

describe 'hadoop::hdfsmaster' do

  chef_run = ChefSpec::ChefRunner.new(platform:'ubuntu', version:'13.04') do |node|
    #node.set['my_attribute'] = 'bar'
  end
  chef_run.converge 'hadoop::hdfsslave'
  
  it 'startup datanode service' do
    expect(chef_run).to start_service 'datanode'
  end
end
