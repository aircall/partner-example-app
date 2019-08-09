# Partner Example App
A partner application example that performs Aircall's OAuth flow

## What is this?

This app is an example of how you can easily connect to Aircall's ecosystem.
It:
- implements Aircall's OAuth flow
- creates a webhook on Aircall so it is notified on specific events

### Endpoints

#### GET /oauth/install
[See code](controllers/oauth.rb#L14)

This endpoint is the entry-point of the install flow of the application. It is called when a user clicks on "Install" in Aircall's dashboard.
It redirects to the Aircall consent page so the user can authorize the application.

You can implement custom logic at this step, however you must redirect to Aircall's consent page at the end of your execution.

#### GET /oauth/callback
[See code](controllers/oauth.rb#L23)

This endpoint is called once the user has authorized the application. An `authorization_code` is given in the `code` GET param, which can be used to create an access token in order to interact with Aircall's Public API.
The `code` param is fetched from the URL, then the [Oauth::CreateAccessToken](services/oauth/create_access_token.rb) service is called to create the access token on Aircall's Public API.
Once this is done, the [Webhooks::Create](services/webhooks/create) service is used to create a webhook on Aircall's Public API.

#### POST /webhooks
[See code](controllers/webhooks.rb#L6)

This endpoint is called when a subscribed event happens on Aircall.
In this example, the `call.created` event is subscribed to, so `POST /webhooks` will be called everytime an inbound or outbound call is created.

## Running locally

Pre-requesites: a running Docker engine.

Clone the repo, then run:
- `docker-compose up --build` to launch the server. Whenever a file is changed, the server is restarted, tests are re-runned and doc is generated.
- `docker-compose down` to stop all containers created by `up`

### Environment variables

You need to have a `.env` file at the root of the folder with all variables described in `.env.test`
Fill your OAuth client id and secret with the values provided by Aircall. If you don't have those, fill in [this form](https://aircall.io/partners/registration/) and
we'll be in touch.
