# frozen_string_literal: true

module Services
  # Regroups the services handling the OAuth flow
  module Oauth
    # Handles the install process of the app.
    # Redirect to Aircall's consent page.
    class Install
      # Entry point of the Install service
      #
      # @return [String] the consent page URI
      def call
        # You can perform custom actions here

        # Setup your OAuth params
        oauth_params = {
          client_id: ENV['CLIENT_ID'],
          redirect_uri: ENV['REDIRECT_URI'],
          response_type: 'code',
          scope: 'public_api'
          # optional state param
          # state: ...
        }

        # Build and return the consent page URI with the GET params
        build_consent_page_uri(ENV['AIRCALL_CONSENT_PAGE_URL'], oauth_params)
      end

      private

      def hash_to_query_params(hash)
        hash.map { |p| p.join('=') }.join('&')
      end

      def build_consent_page_uri(host, params)
        host + '?' + hash_to_query_params(params)
      end
    end
  end
end
