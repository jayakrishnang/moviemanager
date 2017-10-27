class GenresController < ApplicationController
  def index
    @genres = Genre.all
  end

  def show
    @genre = Genre.where(id: params[:id]).first
    @movies = @genre.movies
  end
end
