# frozen_string_literal: true

module Controllers
  # Controller handling the OAuth flow
  class Oauth < Base
    include ::AutoInject[
      oauth_install: 'services.oauth.install'
    ]

    # This endpoint launches the install flow of the application.
    # In this action, we will redirect to Aircall's consent page.
    get '/install' do
      uri = oauth_install.call

      redirect uri
    end
  end
end
