class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_activities

  def fetch_most_watched_genres
    genres = User.select('COUNT(*) AS genre_count, genres.name')
              .joins("INNER JOIN user_activities ON user_activities.user_id = users.id AND user_activities.user_id = #{id}")
              .joins('INNER JOIN movies ON user_activities.movie_id = movies.id')
              .joins('INNER JOIN movies_genres ON movies_genres.movie_id = movies.id')
              .joins('INNER JOIN genres ON movies_genres.genre_id = genres.id')
              .group('genres.id')
    genres.map{|genre| {genre.name => genre.genre_count}}.reduce({}, :merge)
  end
end
