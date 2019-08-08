# frozen_string_literal: true

# Container for dependency injection
class Container
  extend Dry::Container::Mixin

  namespace('services') do
    namespace('oauth') do
      register('install') { Services::Oauth::Install.new }
      register('create_access_token') { Services::Oauth::CreateAccessToken.new }
    end
    namespace('webhooks') do
      register('create') { Services::Webhooks::Create.new }
    end
    register('aircall_client') { Services::AircallClient.new }
  end
end

# Injector helper class
AutoInject = Dry::AutoInject(Container)
