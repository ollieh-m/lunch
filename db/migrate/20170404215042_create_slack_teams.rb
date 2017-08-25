class CreateSlackTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :slack_teams do |t|
      t.string :access_token
      t.string :team_name
      t.string :team_id

      t.timestamps
    end

    add_index :slack_teams, :team_id
  end
end
