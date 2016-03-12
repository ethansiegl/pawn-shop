class CreatePieces < ActiveRecord::Migration
  def change
    create_table :pieces do |t|
    	t.integer :x_coordinate
    	t.integer :y_coordinate
    	t.string :color
    	t.boolean :taken
        t.timestamps
    end
  end
end
