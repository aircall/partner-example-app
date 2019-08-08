# frozen_string_literal: true

require 'rubygems'
require 'bundler'
require './app'

# Run the routes file
run Controllers::Router.routes
