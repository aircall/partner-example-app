# frozen_string_literal: true

module Controllers
  # Router class that defines application HTTP API routes.
  # The router is used by Rack to start the application.
  # @see `config.ru`
  class Router
      # Returns a URLMap for Rack to start the application.
      # The map mounts controllers into mounting points. The final URL of an API endpoint is composed of
      # the mounting path and controller handler path.
      # @return [Rack::URLMap] a URLMap describing routes of the application
      def self.routes
        Rack::URLMap.new(
          '/' => Base.new,
          '/oauth' => Oauth.new,
          '/webhooks' => Webhooks.new
        )
      end
  end
end
