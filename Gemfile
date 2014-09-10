# A sample Gemfile
source "https://rubygems.org"

group :test do
  gem 'chefspec'
end

group :systemtest do

  # To manage cookbooks required for systemtests
  gem 'berkshelf'

  # Tool to test cookbook in virtual environment
  gem 'test-kitchen', '1.2.1'
  # Docker driver for test-kitchen
  gem 'kitchen-docker'
end

group :development do

  gem 'guard-bundler'
  gem 'guard-rspec'
  # Guard notification in Mac
  gem 'terminal-notifier-guard'
  gem 'guard-shell'

  # Lint tool for cookbooks
  gem 'foodcritic', '<3.0' #<3.0 for guard-foodcritic
  gem 'guard-foodcritic'

  # Tailor to validate Ruby code style
  #gem 'tailor'
  gem 'rubocop'
end
