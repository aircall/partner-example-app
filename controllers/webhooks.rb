# frozen_string_literal: true

module Controllers
  # Controller handling the incoming webhooks events
  class Webhooks < Base
    post '/?' do
      # Do something with the event
      # ...

      # Acknowledge the reception
      status 200
    end
  end
end
