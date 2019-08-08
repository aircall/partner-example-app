# Container for dependency injection
class Container
  extend Dry::Container::Mixin
end

# Injector helper class
AutoInject = Dry::AutoInject(Container)
