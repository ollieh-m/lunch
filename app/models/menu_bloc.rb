class MenuBloc < ApplicationRecord
  has_many :menu_bloc_memberships
  has_many :menus, through: :menu_bloc_memberships
end
