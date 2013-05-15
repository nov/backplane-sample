class Engage::TokensController < ApplicationController
  def create
    engage_token = Rack::OAuth2::AccessToken::Bearer.new(access_token: params[:token])
    # backplane_token, backplane_channel, backplane_refresh_token = cookies[:'backplane2-channel'].split(':')
    # backplane_token = Rack::OAuth2::AccessToken::Bearer.new(access_token: backplane_token)
    # backplane_message = {
    #   message: {
    #     type: 'identity/login',
    #     sticky: false,
    #     bus: 'gree.net',
    #     channel: backplane_channel,
    #     payload: {
    #       context: 'hello'
    #     }
    #   }
    # }
    # backplane_token.post(
    #   'https://backplane1.janrainbackplane.com/v2/message',
    #   backplane_message.to_json,
    #   'Content-Type' => 'application/json'
    # )

    # Janrain Engage API endpoint is not OAuth2 protected resource, I'm using Rack::OAuth2 for debugging purpose here.
    response = engage_token.post(
      'https://rpxnow.com/api/v2/auth_info',
      apiKey: '0ecaee594408e452a2e19752c61ef19f9b38c801',
      token: params[:token]
    )
    render json: response.body
  end
end
