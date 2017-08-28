class MenuBlocBuilder

  def initialize(params)
    @params = params
  end

  def perform
    return extract_menus_to_group unless extract_menus_to_group[:success]
    create_menu_bloc_with_menus
  end

  def extract_menus_to_group
    @extract ||= begin
      selected_menus = @params.select{|k,v| v == '1'}
      if selected_menus.length > 0
        {success: true, content: selected_menus.keys.map(&:to_i)}
      else
        {success: false, content: 'No menus selected'}
      end
    end
  end

  def create_menu_bloc_with_menus
    bloc = MenuBloc.create
    bloc.menus << Menu.where(id: extract_menus_to_group[:content])
    {success: true, content: bloc}
  end

end
