class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
    	t.integer :white_player_id
    	t.integer :black_player_id
    	t.integer :winning_player_id
    	t.string :turn
      t.timestamps
    end
  end
end
