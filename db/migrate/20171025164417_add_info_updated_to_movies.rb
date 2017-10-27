class AddInfoUpdatedToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :info_updated, :boolean, default: false
  end
end
