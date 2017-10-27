class MoviesController < ApplicationController
  def index
  	@movies = Movie.all.order(:title)
  end

  def show
  	@movie = Movie.where(id: params[:id]).first
  end

  def list_years
  	@years = Movie.pluck(:year).compact.uniq.sort.reverse
  end

  def list_movies_by_year
  	@year = params['year']
  	@movies = Movie.where(year: @year)
  end

  def open_movie_folder
    movie = Movie.where(id: params[:movie_id]).first
    home_folder = "/media/rmed178lt/Seagate\ Backup\ Plus\ Drive/Movies/English/"
    system("xdg-open '#{home_folder}#{movie.location}'")
    flash['warning'] = 'Folder may open in background! Do check.'
    redirect_to movie_path(movie)
  end

  def play_movie
    movie = Movie.where(id: params[:movie_id]).first
    home_folder = "/media/rmed178lt/Seagate\ Backup\ Plus\ Drive/Movies/English/"
    system("xdg-open '#{home_folder}#{movie.location}#{movie.file_name}'")
    render json: {status: 'success'}
  end

  def download_movie_file
    movie = Movie.where(id: params[:movie_id]).first
    home_folder = "/media/rmed178lt/Seagate\ Backup\ Plus\ Drive/Movies/English/"
    send_file("#{home_folder}#{movie.location}#{movie.file_name}", disposition: "attachment;filename=#{movie.file_name}")
    # p "#{movie.location}/#{movie.file_name}"
    # send_file "#{movie.location}/#{movie.file_name}",type: "application/jpg", disposition: 'attachment'
    # send_file '/home/rmed178lt/Documents/eraop.csv', type: "text/csv", stream: false, disposition: "attachment;filename=eraop.csv"
    puts 'hi'
  end
end
