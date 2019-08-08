# frozen_string_literal: true

module Services
  # Regroups the services handling the OAuth flow
  module Oauth
    # Handles the creation of the Aircall Access Token from the
    # authorization_code.
    class CreateAccessToken
      include ::AutoInject[
        aircall_client: 'services.aircall_client'
      ]

      # Entry point to the CreateAccessToken service
      #
      # @return [String] the access token
      def call(authorization_code)
        response = aircall_client.create_access_token(authorization_code: authorization_code)

        return nil unless response.success?

        JSON.parse(response.body)['access_token']
      end
    end
  end
end
