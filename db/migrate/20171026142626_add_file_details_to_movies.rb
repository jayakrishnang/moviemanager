class AddFileDetailsToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :file_name, :string
    add_column :movies, :location, :string
  end
end
