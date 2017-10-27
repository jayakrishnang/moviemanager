class MovieDataFetcher
	def initialize(api_path, movie_id = nil)
		if movie_id.present?
			@movies = Movie.where(id: movie_id)
		else
			@movies = Movie.where(info_updated: false)
		end
		@genres = Genre.pluck(:name)
		@api_path = api_path
	end

	def update_movie_info
		updated_movies = []
		@movies.each do |movie|
			response =  HTTParty.get(@api_path.gsub('movie_title', movie.title))
			parse_and_save(movie, response)
		end
	end

	def parse_and_save(movie, response)
		if response['status'] == 'ok'
			data = response['data']
			if data['movie_count'] == 1
				save_info(movie, data['movies'].first)
			elsif data['movie_count'] > 1
				selected_movies = nil
				data['movies'].each do |movie_info|
					selected_movies = movie_info if movie_info['year'] == movie.year
				end
				save_info(movie, selected_movies) if selected_movies.present?
			end
		end
	end

	def save_info(movie, movie_details)
		puts '------------------------------------------'
		puts "Parsing #{movie.title}"
		genre_names = movie_details['genres']
		genre_names.each do |genre_name|
			unless @genres.include?(genre_name)
				genre = Genre.create(name: genre_name)
				@genres << genre_name
			else
				genre = Genre.select(:id).where(name: genre_name).first
			end
			unless MoviesGenre.exists?(movie_id: movie.id, genre_id: genre.id)
				MoviesGenre.create(movie_id: movie.id, genre_id: genre.id)
			end
		end
		movie.year = movie_details['year']
		movie.synopsis = movie_details['synopsis']
		movie.imdb_rating = movie_details['rating']
		movie.duration = movie_details['runtime']
		movie.info_updated = true
		movie.poster = movie_details['medium_cover_image']
		movie.save
	end
end
