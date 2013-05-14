class Engage::TokensController < ApplicationController
  def create
    engage_token = Rack::OAuth2::AccessToken::Bearer.new(access_token: params[:token])
    backplane_token, backplane_channel, backplane_refresh_token = cookies[:'backplane2-channel'].split(':')
    backplane_token = Rack::OAuth2::AccessToken::Bearer.new(access_token: backplane_token)
    backplane_message = {
      message: {
        type: 'identity/login',
        sticky: false,
        bus: 'gree.net',
        channel: backplane_channel,
        payload: {
          context: 'hello'
        }
      }
    }
    backplane_token.post(
      'https://backplane1.janrainbackplane.com/v2/message',
      backplane_message.to_json,
      'Content-Type' => 'application/json'
    )
    render text: 'hello'
  end
end
