class Movie < ActiveRecord::Base
	has_many :movies_genres
	has_many :genres, through: :movies_genres
	has_many :user_activities
	belongs_to :franchise
	scope :with_user_activity, lambda { |user_id|
						joins("LEFT OUTER JOIN user_activities
										ON user_activities.movie_id = movies.id AND user_id=#{user_id}") }
end
