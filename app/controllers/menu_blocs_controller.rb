class MenuBlocsController < FrontendBaseController

  def create
    MenuBlocs::Create.new(params).perform
    redirect_to menus_path
  end

end
