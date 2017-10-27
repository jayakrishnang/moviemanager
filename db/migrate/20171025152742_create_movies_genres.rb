class CreateMoviesGenres < ActiveRecord::Migration
  def change
    create_table :movies_genres do |t|
    	t.references :movie
      t.references :genre
    end
  end
end
