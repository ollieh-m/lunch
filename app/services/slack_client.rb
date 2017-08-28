class SlackClient

  def self.link_account(authorization_code:, redirect_uri:)
    response = HttpRequest.new(url: 'https://www.slack.com/api/oauth.access',
                    method: :post,
                    data: { 'code' => authorization_code,
                            'client_secret' => ENV['SLACK_SECRET'],
                            'client_id' => ENV['SLACK_ID'],
                            'redirect_uri' => redirect_uri },
                    headers: { 'Content-type' => 'application/x-www-form-urlencoded' } ).perform

    if response[:status] == 200
      team = SlackTeam.find_or_initialize_by(team_id: response[:body]['team_id'])
      team.update_attributes(response[:body].extract!('access_token', 'team_name'))
      return team if team.save
    end
  end

  def self.get_members(slack_team)
    response = HttpRequest.new(url: 'https://slack.com/api/users.list',
                method: :post,
                data: { 'token' => slack_team.access_token } ).perform

    if response[:status] == 200
      array_of_users = response[:body]['members'].map do |member|
        User.find_or_create_by(slack_id: member['id'], name: member['name'])
      end
      {success: true, content: array_of_users}
    else
      {success: false, content: 'Could not get members'}
    end
  end

  def self.send_menu(slack_team, array_of_users, menu_attachments)
    array_of_users.each do |user|
      HttpRequest.new(url: 'https://slack.com/api/chat.postMessage',
                      method: :post,
                      headers: { 'Content-type' => 'application/x-www-form-urlencoded' },
                      data: { 'token' => slack_team.access_token,
                              'channel' => "@#{user['name']}",
                              'text' => "Please make your choice...",
                              "response_type" => "in_channel",
                              'attachments' => menu_attachments.to_json } ).perform

    end
  end

end
