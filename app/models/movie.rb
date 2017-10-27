class Movie < ActiveRecord::Base
	has_many :movies_genres
	has_many :genres, through: :movies_genres
	belongs_to :franchise
end
