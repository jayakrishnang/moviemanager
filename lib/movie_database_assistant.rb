class MovieDatabaseAssistant
	EXCLUDE_LIST = ['.','..','.folder_icon.png','ANIME',
									'3D COLLECTION','A-F','G-L','M-S','T-Z',
									'Thanks','Sample','Screenshot',
									'SUBS','Subs','Sub','SubFiles','Other','covers']
	MOVIE_EXTENSIONS = ['.mp4', '.mkv', '.avi', '.m4v']
	def initialize(path = nil)
		@path ||= "/media/rmed178lt/Seagate\ Backup\ Plus\ Drive/Movies/English/"
		@movie_list = Dir.glob("#{@path}**/*/")
	end

	def populate_movie_db
		movies = []
		franchise = nil
		@movie_list.each do |movie_path|
			movie_name = movie_path.split('/').last
			if EXCLUDE_LIST.include? movie_name
				next
			elsif movie_name.match(/Collection$|Trilogy$|Series$|Universe$/).present?
				franchise = Franchise.create(name: movie_name)
			else
				if movie_name.match(/ \(\d{4}\)/)
					year = movie_name.match(/ \(\d{4}\)/).to_s.match(/\d{4}/).to_s.to_i
					movie_name = movie_name.gsub(/ \(\d{4}\)/, '')
				end
				if movie_name.match(/ \[\d{3,4}p\]/)
					quality = movie_name.match(/ \[\d{3,4}p\]/).to_s.match(/\d{3,4}p/).to_s
					movie_name = movie_name.gsub(/ \[\d{3,4}p\]/, '')
				end
				unless Movie.exists?(title: movie_name, year: year, quality: quality)
					new_movie = Movie.new(title: movie_name, year: year, quality: quality)
					if franchise.present?
						if movie_path.include? franchise.name
							new_movie.franchise_id = franchise.id
						else
							franchise = nil
						end
					end
					file_name = find_file_name(movie_path)
					new_movie.file_name = file_name
					new_movie.location = movie_path.gsub(@path, '')
					movies << new_movie
				end
			end
		end
		result = Movie.import movies
    puts "#{result} movies imported"
	end

	def find_file_name(movie)
		files = Dir.glob "#{movie.gsub('[', '\[')}*"
		movie_file_name = nil
		files.each do |file|
			MOVIE_EXTENSIONS.each do |extension|
				if file.ends_with?(extension) && file.upcase.exclude?('TRAILER')
					movie_file_name = file.split('/').last
				end
			end
		end
		movie_file_name
	end
end
