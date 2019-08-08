# frozen_string_literal: true

describe Controllers::Oauth, type: :controller do
  describe 'GET #install' do
    let(:consent_page_uri) do
      "https://dashboard-v2.aircall.io/oauth/authorize?client_id=foo&redirect_uri=https://test.com&response_type=code&scope=public_api"
    end

    before do
      get '/install'
    end

    it 'redirects to Aircall consent page' do
      expect(last_response).to be_redirect
      expect(last_response.headers['Location']).to eq(consent_page_uri)
    end
  end
end
