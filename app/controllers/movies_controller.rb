class MoviesController < ApplicationController
  def index
    @movies = Movie.select('movies.*, activity').with_user_activity(current_user.try(:id)).order(:title)
  end

  def unwatched_movies
    @movies = Movie.select('movies.*, activity').with_user_activity(current_user.try(:id))
                .where('activity IS NULL').order(:title)
  end

  def recommended_movies
    @movies = RecommendationEngine.new(current_user.try(:id)).get_recommended_movies
  end

  def recommended_unwatched_movies
    @movies = RecommendationEngine.new(current_user.try(:id)).get_unwatched_recommended_movies
  end

  def show
    @movie = Movie.select('movies.*, activity').with_user_activity(current_user.try(:id)).where(id: params[:id]).first
  end

  def list_years
    @years = Movie.pluck(:year).compact.uniq.sort.reverse
  end

  def list_movies_by_year
    @year = params['year']
    @movies = Movie.select('movies.*, activity').with_user_activity(current_user.try(:id)).where(year: @year)
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
    home_folder = "#{Rails.root}/videos/English/"
    send_file("#{home_folder}#{movie.location}#{movie.file_name}", disposition: "attachment;filename=#{movie.file_name}", stream: true)
    puts 'hi'
  end

  def toggle_marked_status
    movie = Movie.select(:id).where(id: params[:movie_id]).first
    unless UserActivity.exists?(user_id: current_user.id, movie_id: movie.id)
      UserActivity.create(user_id: current_user.id, movie_id: movie.id, activity: 'Seen')
    else
      activity = UserActivity.where(user_id: current_user.id, movie_id: movie.id).first
      activity.destroy if activity.present?
    end
    render json: {status: 'success'}
  end
end
