class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :player_one
      t.integer :player_two
      t.jsonb :session_data, default: {}, null: false, using: :gin
      t.timestamps
    end
  end
end
