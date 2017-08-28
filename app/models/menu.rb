class Menu < ApplicationRecord
  has_many :options
  has_many :menu_bloc_memberships
  has_many :menu_blocs, through: :menu_bloc_memberships
end
