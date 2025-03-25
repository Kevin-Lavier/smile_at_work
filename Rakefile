# Set up Bundler to load all the gems from your Gemfile
require 'bundler/setup'

# Load the main application file (app.rb) so that the application environment is initialized
require './app'

# Require the Sinatra ActiveRecord Rake tasks, which provide database migration and other tasks
require 'sinatra/activerecord/rake'

# Import any custom rake tasks defined in the lib/tasks directory
Dir.glob('lib/tasks/*.rake').each { |r| import r }
