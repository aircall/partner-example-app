# frozen_string_literal: true

module Controllers
  # Controller handling the OAuth flow
  class Oauth < Base
    include ::AutoInject[
      oauth_install: 'services.oauth.install',
      oauth_create_access_token: 'services.oauth.create_access_token',
      webhooks_create: 'services.webhooks.create'
    ]

    # This endpoint launches the install flow of the application.
    # In this action, we will redirect to Aircall's consent page.
    get '/install' do
      uri = oauth_install.call

      redirect uri
    end

    # This endpoint is triggered when the OAuth flow is finished.
    # The authorization_code is in the `code` GET param, it is used to
    # generate an access token
    get '/callback' do
      # Check the state to make sure it comes from Aircall

      # Get the authorization code from the GET params
      authorization_code = params['code']

      unless params['code']
        error_body = { error: 'No authorization code provided' }
        body error_body.to_json
        halt 400
      end

      # Create the access token from the authorization code
      access_token = oauth_create_access_token.call(authorization_code)
      # You will probably want to store the access_token

      unless access_token
        error_body = { error: 'Access token creation failed' }
        body error_body.to_json
        halt 400
      end

      # Do something with the token, like creating a webhook
      webhooks_create.call(access_token)

      redirect ENV['AIRCALL_SUCCESS_PAGE_URL']
    end
  end
end
