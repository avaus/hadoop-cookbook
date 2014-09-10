require 'chefspec'

describe 'hadoop::hdfsmaster' do

  chef_run = ChefSpec::ChefRunner.new(platform:'ubuntu', version:'13.04') do |node|
    #node.set['my_attribute'] = 'bar'
  end
  chef_run.converge 'hadoop::hdfsmaster'
  
  it 'startup namenode service' do
    expect(chef_run).to start_service 'namenode'
  end
end
