source 'https://rubygems.org'

ruby(File.read(".ruby-version").strip) if ENV["GEMFILE_LOAD_RUBY_VERSION"].to_i == 1 && File.exist?(".ruby-version")

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.0.0.1'
gem 'pg'
gem "responders"
gem 'doorkeeper'
gem 'puma'
gem 'aasm'
gem 'phony_rails'
gem 'phony', :github => "dwilkie/phony", :branch => "add_telesom_prefix_for_somalia"
gem 'money-rails'

gem 'refile', :github => "refile/refile", :require => "refile/rails"
gem "refile-s3", :github => "refile/refile-s3"
# Needed for Refile
gem 'sinatra', :github => "sinatra/sinatra"

gem 'bitmask_attributes', :github => "numerex/bitmask_attributes"

# Add your custom call routing logic
gem 'twilreapi-active_call_router', :github => "dwilkie/twilreapi-active_call_router"
gem 'twilreapi-active_call_router-pin_cambodia', :github => "dwilkie/twilreapi-active_call_router-pin_cambodia"

# Add your custom billing logic
gem 'twilreapi-active_biller', :github => "dwilkie/twilreapi-active_biller"
gem 'twilreapi-active_biller-pin_cambodia', :github => "dwilkie/twilreapi-active_biller-pin_cambodia"

# Use active_elastic_job as queue adapter and excute jobs in this application
gem 'active_elastic_job', :github => "tawan/active-elastic-job"
gem 'twilreapi-worker',   :github => "dwilkie/twilreapi-worker"

# Use shoryuken as queue adapter
# gem 'shoryuken'

# Use Sidekiq as queue adapter
# gem 'sidekiq'
#gem 'sinatra', :github => "sinatra/sinatra", :require => false
#gem 'rack-protection', :github => "sinatra/rack-protection", :require => false

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'pry'
  gem 'rspec-rails'
end

group :development do
  gem 'foreman'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :test do
  gem 'factory_girl_rails'
  gem 'shoulda-matchers'
end

