class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :movie_id
      t.boolean :like

      t.timestamps
    end
  end
end
