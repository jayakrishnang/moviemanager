module MoviesHelper
	def seen_label(movie)
		if movie.activity == 'Seen'
			'seen'
		else
			''
		end
	end

	def movie_toggle_watch_link(movie)
		if movie.activity == 'Seen'
			"SEEN"
		else
			"UNSEEN"
		end
	end

	def watch_button_class(movie)
		if movie.activity == 'Seen'
			'btn-success'
		else
			'btn-red'
		end
	end
end
