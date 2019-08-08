# frozen_string_literal: true

describe Controllers::Oauth, type: :controller do
  describe 'GET /install' do
    let(:consent_page_uri) do
      'https://dashboard-v2.aircall.io/oauth/authorize?client_id=foo&redirect_uri=https://test.com&response_type=code&scope=public_api'
    end

    before do
      get '/install'
    end

    it 'redirects to Aircall consent page' do
      expect(last_response).to be_redirect
      expect(last_response.headers['Location']).to eq(consent_page_uri)
    end
  end

  describe 'GET /callback' do
    let(:params) { { code: 'abcdefghijklmnop' } }

    context 'when OAuth flow succeeded' do
      let(:create_access_token_body) do
        {
          grant_type: 'authorization_code',
          code: params[:code],
          redirect_uri: ENV['REDIRECT_URI'],
          client_id: ENV['CLIENT_ID'],
          client_secret: ENV['CLIENT_SECRET']
        }
      end
      let(:create_access_token_response) do
        {
          access_token: '2d492d492d492d492d492d492d492d492d492d49',
          token_type: 'Bearer',
          created_at: Time.now.to_i
        }
      end
      let(:create_webhook_body) do
        {
          url: "#{ENV['APP_URL']}/webhooks",
          events: ['call.created']
        }
      end

      context 'when the access token creation succeeds' do
        before do
          # Stub the Access token creation request
          stub_request(:post, "#{ENV['AIRCALL_PUBLIC_API_HOST']}/v1/oauth/token")
            .with(body: create_access_token_body.to_json)
            .to_return(status: 200, body: create_access_token_response.to_json)

          # Stub the Webhook creation request
          stub_request(:post, "#{ENV['AIRCALL_PUBLIC_API_HOST']}/v1/webhooks")
            .with(
              body: create_webhook_body.to_json,
              headers: {
                'Authorization' => "Bearer #{create_access_token_response[:access_token]}"
              }
            )
            .to_return(status: 201)

          get '/callback', params
        end

        it 'returns a success' do
          expect(last_response).to be_redirect
          expect(last_response.headers['Location'])
            .to eq(ENV['AIRCALL_SUCCESS_PAGE_URL'])
        end
      end

      context 'when the access token creation fails' do
        let(:create_access_token_response) do
          {
            error: 'some error'
          }
        end

        before do
          # Stub the Access token creation request
          stub_request(:post, "#{ENV['AIRCALL_PUBLIC_API_HOST']}/v1/oauth/token")
            .with(body: create_access_token_body.to_json)
            .to_return(status: 400, body: create_access_token_response.to_json)

          get '/callback', params
        end

        it 'returns a Bad Request error' do
          expect(last_response).to be_bad_request
        end
      end
    end

    context 'when OAuth flow failed' do
      let(:params) { { error: 'invalid_client' } }

      before do
        get '/callback', params
      end

      it 'returns a Bad Request error' do
        expect(last_response).to be_bad_request
      end
    end
  end
end
