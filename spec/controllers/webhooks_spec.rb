# frozen_string_literal: true

describe Controllers::Webhooks, type: :controller do
  describe 'POST /' do
    before do
      post '/'
    end

    it 'responds with a success' do
      expect(last_response).to be_ok
    end
  end
end
