class CreateMenuBlocs < ActiveRecord::Migration[5.0]
  def change
    create_table :menu_blocs do |t|

      t.timestamps
    end
  end
end
