# frozen_string_literal: true

ENV['RACK_ENV'] ||= 'development'
Bundler.require(:default, ENV['RACK_ENV'])

# Require app files
Dir[File.expand_path('controllers/**/*.rb', __dir__)].each(&method(:require))
Dir[File.expand_path('services/**/*.rb', __dir__)].each(&method(:require))

# Load dependency injection container
require File.expand_path('container.rb', __dir__)
