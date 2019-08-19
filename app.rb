# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, ENV['RACK_ENV'])

# Load dependency injection container
require File.expand_path('container.rb', __dir__)

# Require controllers
require File.expand_path('controllers/controllers.rb', __dir__)

# Require services
Dir[File.expand_path('services/**/*.rb', __dir__)].each(&method(:require))
