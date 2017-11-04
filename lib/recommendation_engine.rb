class RecommendationEngine
	def initialize(user_id)
		@user = User.find(user_id)
		@genre_count_map = @user.fetch_most_watched_genres
		calculate_movie_scores
	end

	def get_recommended_movies
		Movie.select('movies.*, activity').with_user_activity(@user.id)
					.sort_by{|movie| @movie_score_map[movie.id] || 0}.reverse
	end

	def get_unwatched_recommended_movies
		Movie.select('movies.*, activity').with_user_activity(@user.id)
					.where('activity IS NULL')
					.sort_by{|movie| @movie_score_map[movie.id] || 0}.reverse
	end

	private
	def calculate_movie_scores
		movies = Movie.select('movies.id, GROUP_CONCAT(genres.name) AS genre_names').joins(:genres).group('movies.id')
		@movie_score_map = {}
		movies.each do |movie|
			@movie_score_map[movie.id] = movie.genre_names.split(',').sum{|genre| @genre_count_map[genre]}
		end
	end
end
