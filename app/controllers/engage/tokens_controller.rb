class Engage::TokensController < ApplicationController
  def create
    profile = engage_profile_for params[:token]
    bp_broadcast! profile
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

  # NOTE: Once I got an Backplane enabled Janrain Engage account, this shouldn't be needed.
  def bp_broadcast!(profile)
    channel = cookies[:'backplane2-channel'].split(':')[1]
    bp_access_token.post(
      'https://backplane1.janrainbackplane.com/v2/message',
      {
        message: {
          type: 'identity/login',
          sticky: true,
          bus: 'gree.net',
          channel: channel,
          payload: profile
        }
      }.to_json,
      'Content-Type' => 'application/json'
    )
  end

  def bp_access_token
    client = Rack::OAuth2::Client.new(
      identifier: 'gree_client',
      secret: 'yaiZ5thaileiro',
      grant_type: 'client_credentials',
      token_endpoint: 'https://backplane1.janrainbackplane.com/v2/token'
    )
    client.access_token!
    # (scope: [
    #   'bus:bree.net',
    #   'source:https://backplane.dev',
    #   'type:identity/login sticky:true'
    # ])
  end
end
