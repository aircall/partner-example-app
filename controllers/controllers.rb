# frozen_string_literal: true

# Load Base controller first
require File.expand_path('base.rb', __dir__)

# Require other controllers
Dir[File.expand_path('*.rb', __dir__)].each(&method(:require))
