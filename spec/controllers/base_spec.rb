# frozen_string_literal: true

describe Controllers::Base, type: :controller do
  describe 'GET #ping' do
    before do
      get '/ping'
    end

    it 'responds with a success' do
      expect(last_response).to be_ok
      expect(last_response.body).to eq('pong')
    end
  end
end
