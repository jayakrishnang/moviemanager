class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.text :synopsis
      t.date :release_date
      t.integer :franchise_id
      t.integer :cinematographer_id
      t.decimal :imdb_rating, :precision => 10, :scale => 2
      t.integer :rotten_tomatoes_score
      t.integer :rotten_tomatoes_critics_score
      t.string :quality, limit: 10
      t.decimal :duration, :precision => 10, :scale => 2
      t.string :certification, limit:5
      t.timestamps null: false
    end
  end
end
