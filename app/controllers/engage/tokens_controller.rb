class Engage::TokensController < ApplicationController
  def create
    token = Rack::OAuth2::AccessToken::Bearer.new(access_token: params[:token])
    message = {
      source: root_url,
      type: 'identity/login',
      payload: {
        context: 'hello'
      }
    }
    token.post(
      params[:channel],
      message.to_json,
      'Content-Type' => 'application/json'
    )
    render text: 'hello'
  end
end
