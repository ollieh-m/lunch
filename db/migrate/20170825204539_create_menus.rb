class CreateMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :menus do |t|
      t.date :date

      t.timestamps
    end

    create_table :meals do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    create_table :options do |t|
      t.references :menu, foreign_key: true
      t.references :meal, foreign_key: true

      t.timestamps
    end

    create_table :users do |t|
      t.string :slack_id
      t.string :name

      t.timestamps
    end

    create_table :choices do |t|
      t.references :user, foreign_key: true
      t.references :option, foreign_key: true

      t.timestamps
    end
  end
end
