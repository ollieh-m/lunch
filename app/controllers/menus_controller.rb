class MenusController < FrontendBaseController

  def new
    @form = MenuForm.new(Menu.new(date: Date.current)).prepopulate!
  end

  def index
    @menus = Menu.all
  end

  def create
    @form = MenuForm.new(Menu.new)
    if @form.validate(params[:menu]) && @form.save
      redirect_to menus_path
    else
      render :new
    end
  end

end
