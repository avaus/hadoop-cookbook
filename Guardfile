
# RSpec
guard :rspec, spec_paths: ["spec"] do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/spec_helper\.rb$}) { 'spec' }
  watch(%r{^recipes/(.+)\.rb$}) do |m|
    "spec/#{m[1]}_spec.rb"
  end
end

# Foodcritic
# guard :foodcritic, :cli => "--epic-fail any -I foodcritic_rules/*", :cookbook_paths => "." do
#   watch(%r{^attributes/.+\.rb$})
#   watch(%r{^providers/.+\.rb$})
#   watch(%r{^recipes/.+\.rb$})
#   watch(%r{^resources/.+\.rb$})
#   watch(%r{^spec/.+\.rb$})
# end

# Tailor
guard 'shell' do
  watch(%r{^(attributes|files|recipes|spec|templates).+\.rb}) do |m| 
    system("tailor #{m[0]}") 
  end
end

# Bundler
guard :bundler do
  watch('Gemfile')
end