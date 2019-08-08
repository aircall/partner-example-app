# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.6.1'

gem 'puma', '>= 3.12', '< 5.0'
gem 'sinatra', '~> 2.0'
gem 'sinatra-contrib', '~> 2.0'
gem 'dry-auto_inject'

group :development, :test do
  gem 'guard'
  gem 'guard-process'
  gem 'guard-rack'
  gem 'guard-rspec'
  gem 'pry'
  gem 'pry-byebug'
end

group :development do
  gem 'rubocop', require: false
  gem 'rubocop-performance'
  gem 'rubocop-rspec'
  gem 'yard'
  gem 'yard-sinatra'
end

group :test do
  gem 'rack-test'
  gem 'rspec'
  gem 'simplecov', require: false
end
