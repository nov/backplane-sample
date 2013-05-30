class Engage::TokensController < ApplicationController
  def create
    profile = engage_profile_for params[:token]
    render json: {
      success: true
    }
  end

  private

  def engage_profile_for(token)
    engage_token = Rack::OAuth2::AccessToken::Bearer.new(access_token: params[:token])
    JSON.parse engage_token.post(
      'https://rpxnow.com/api/v2/auth_info',
      apiKey: '0ecaee594408e452a2e19752c61ef19f9b38c801',
      token: token
    ).body
  end
end
