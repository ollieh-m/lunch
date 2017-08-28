class CreateMenuBlocMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_bloc_memberships do |t|
      t.references :menu, foreign_key: true
      t.references :menu_bloc, foreign_key: true

      t.timestamps
    end
  end
end
