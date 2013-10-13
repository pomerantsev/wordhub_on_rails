source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~> 4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg', '~> 0.15.1'

gem 'unicorn', '~> 4.6.3'

gem 'validates_existence', github: 'perfectline/validates_existence'
gem 'validates_timeliness', '~> 3.0'
gem 'simple_enum', '~> 1.6.7'

group :development do
	gem 'annotate'
end

group :development, :test do
	gem 'rspec-rails', '~> 2.13'
	gem 'factory_girl_rails'
	gem 'guard-rspec', '~> 3.0.2'
	gem 'spork-rails', github: 'sporkrb/spork-rails'
	gem 'guard-spork', '~> 1.5.1'
end

group :test do
	gem 'faker'
	gem 'capybara', github: 'jnicklas/capybara'
	gem "poltergeist", '~> 1.4.1'
	gem 'database_cleaner'
	gem 'launchy'
	gem 'timecop', '~> 0.6.2.2'
end

group :production do
	gem 'rails_12factor'
end

gem 'haml', '~> 4.0.3'
gem 'sass-rails',   '~> 4.0.0'
gem 'bootstrap-sass', '~> 2.3.2.2'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'jquery-ui-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
