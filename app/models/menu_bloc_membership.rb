class MenuBlocMembership < ApplicationRecord
  belongs_to :menu
  belongs_to :menu_bloc
end
