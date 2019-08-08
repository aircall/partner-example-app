# frozen_string_literal: true

module Services
  # Client class to consume Aircall public API
  class AircallClient

    # Calls the create access token endpoint
    # @see https://developer.aircall.io/tutorials/how-aircall-oauth-flow-works/#4-get-an-access-token
    def create_access_token(authorization_code:)
      client.post(
        'v1/oauth/token',
        {
          grant_type: 'authorization_code',
          code: authorization_code,
          redirect_uri: ENV['REDIRECT_URI'],
          client_id: ENV['CLIENT_ID'],
          client_secret: ENV['CLIENT_SECRET']
        }.to_json
      )
    end

    # Calls the create webhook endpoint
    # @see https://developer.aircall.io/api-references/#webhooks
    def create_webhook(access_token:, events:)
      client(token: access_token).post(
        'v1/webhooks',
        {
          url: "#{ENV['APP_URL']}/webhooks",
          events: events
        }.to_json
      )
    end

    private

    # Builds a Faraday client with Aircall Public API base host
    #
    # @return [Faraday::Connection] the Aircall public API client
    def client(token: nil)
      client = Faraday.new(url: ENV['AIRCALL_PUBLIC_API_HOST']) do |faraday|
        faraday.authorization :Bearer, token if token
        faraday.adapter  Faraday.default_adapter
      end

      client
    end
  end
end
