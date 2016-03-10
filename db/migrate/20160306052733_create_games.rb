class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.integer :white_player_id
    	t.integer :black_player_id
    	t.integer :winning_player_id
    	t.integer :turn
    	t.integer :game_id
    	t.string :game_name
      t.timestamps
    end
  end
end
