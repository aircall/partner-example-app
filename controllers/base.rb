# frozen_string_literal: true

module Controllers
  # Controller base class
  class Base < ::Sinatra::Base
    before do
      content_type :json
    end

    register Sinatra::Namespace

    configure :development do
      register Sinatra::Reloader
    end

    # Default Health-check of our application
    get '/ping' do
      status 200
      body 'pong'
    end
  end
end
