class AddSomeFieldsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :year, :integer
    add_column :movies, :runtime, :integer
  end
end
