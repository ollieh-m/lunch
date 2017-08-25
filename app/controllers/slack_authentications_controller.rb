class SlackAuthenticationsController < FrontendBaseController

  def show
    scope = 'scope=chat:write:bot,users:read'
    client_id = 'client_id=' + ENV['SLACK_ID']
    redirect_uri = 'redirect_uri=' + callback_slack_authentication_url
    query_string = [scope, client_id, redirect_uri].join('&')

    redirect_to 'https://slack.com/oauth/authorize?' + query_string
  end

  def callback
    if team = SlackClient.link_account(authorization_code: params['code'], redirect_uri: callback_slack_authentication_url)
      flash[:notice] = "Successfully linked #{team.team_name}"
    else
      flash[:error] = 'Unable to link Slack Team. Please try again.'
    end
    redirect_to root_path
  end

end
