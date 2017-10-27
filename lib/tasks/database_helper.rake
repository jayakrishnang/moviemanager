namespace :database_helper do
  desc "To add/update movie info to db"
  task :populate_movie_db, [:path] => :environment do |t, args|
  	path = args[:path]
    MovieDatabaseAssistant.new(path).populate_movie_db
  end

  desc 'To filter out franchises from movie collections (one time rake)'
  task :filter_franchises => :environment do
  	movies = Movie.all.where(info_updated: false)
  	movies.each do |movie|
  		if movie.title.match(/Collection$|Trilogy$|Series$|Universe$/).present?
  			Franchise.create(name: movie.title)
  			movie.destroy
  		end
  	end
	end
end