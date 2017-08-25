class Lunch::Distribute

  attr_reader :slack_team

  def initialize
    # get the team the user is managing
    @slack_team = SlackTeam.first
  end

  def perform
    binding.pry
    return get_members unless get_members[:success]

    send_menus_to_users
  end

  def get_members
    @get_members ||= ::SlackClient.get_members(slack_team)
  end

  def send_menus_to_users
    ::SlackClient.send_messages(slack_team, get_members[:content], menu_attachments)
  end

  def menu_attachments
    attachments = [
      {
        "text" => "Choose your meals",
        "color" => "#3AA3E3",
        "attachment_type" => "default",
        "callback_id" => "menu_selection",
        "actions" => [
          {
            "name" => "Monday",
            "text" => "Pick your meal for Monday...",
            "type" => "select",
            "options" => [
              {
                "text" => "Meal one",
                "value" => "1"
              },
              {
                "text" => "Meal two",
                "value" => "2"
              }
            ]
          },
          {
            "name" => "Tuesday",
            "text" => "Pick your meal for Tuesday...",
            "type" => "select",
            "options" => [
              {
                "text" => "Meal one",
                "value" => "1"
              },
              {
                "text" => "Meal two",
                "value" => "2"
              }
            ]
          }
        ]
      }
    ]
  end

end
