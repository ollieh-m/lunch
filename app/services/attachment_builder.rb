class AttachmentBuilder

  attr_reader :attachment, :action, :menu, :bloc_id

  def initialize(menu:, bloc_id:)
    @menu = menu
    @bloc_id = bloc_id
    @attachment = {}
    @action = {}
  end

  def perform
    attachment["text"] = "Please choose your meal for #{pretty_date}"
    attachment["color"] = "#3AA3E3"
    attachment["attachment_type"] = "default"
    attachment["callback_id"] = "menu_#{menu.id}_bloc_#{bloc_id}"
    attachment["actions"] = [build_action]
    [attachment]
  end

  def build_action
    action["name"] = "Monday"
    action["text"] = "#{pretty_date}"
    action["type"] = "select"
    action["options"] = build_options
    action
  end

  def build_options
    menu.options.includes(:meal).map do |option|
      {
        "text" => "#{option.meal.name} - #{option.meal.description}",
        "value" => option.id
      }
    end
  end

  def pretty_date
    menu.date.strftime("%A, %B %e")
  end

end
