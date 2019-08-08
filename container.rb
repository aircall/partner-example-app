# frozen_string_literal: true

# Container for dependency injection
class Container
  extend Dry::Container::Mixin

  namespace('services') do
    namespace('oauth') do
      register('install') { Services::Oauth::Install.new }
    end
  end
end

# Injector helper class
AutoInject = Dry::AutoInject(Container)
