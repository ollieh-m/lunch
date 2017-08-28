class MenuBlocs::Create

  attr_reader :slack_team, :params

  def initialize(params)
    @params = params[:menu_block]
    @slack_team = SlackTeam.first
  end

  def perform
    return create_menu_bloc unless create_menu_bloc[:success]
    return get_members unless get_members[:success]

    send_first_menu_to_users
  end

  def create_menu_bloc
    @create_menu_bloc ||= ::MenuBlocBuilder.new(params).perform
  end

  def get_members
    @get_members ||= ::SlackClient.get_members(slack_team)
  end

  def send_first_menu_to_users
    # do in background
    ::SlackClient.send_menu(
      slack_team,
      get_members[:content],
      ::AttachmentBuilder.new(menu: create_menu_bloc[:content].menus.first, bloc_id: create_menu_bloc[:content].id).perform
    )
  end

end
