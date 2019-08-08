# frozen_string_literal: true

module Services
  # Regroups the services handling the OAuth flow
  module Webhooks
    # Handles the creation of a webhook on Aircall
    class Create
      include ::AutoInject[
        aircall_client: 'services.aircall_client'
      ]

      # Entry point of the Create webhook service
      #
      # @param access_token [String] the access token to use on the Public API
      # @return [Hash] the created webhook data
      def call(access_token)
        # Configure which events you want to subscribe to
        # See https://developer.aircall.io/api-references/#events
        events = ['call.created']

        aircall_client.create_webhook(access_token: access_token, events: events)
      end
    end
  end
end
