# Load the rails application
require File.expand_path('../application', __FILE__)

# Force environment
ENV['RAILS_ENV'] ||= 'production'

# Initialize the rails application
Reflexio::Application.initialize!
