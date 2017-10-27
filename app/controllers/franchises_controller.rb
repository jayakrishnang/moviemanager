class FranchisesController < ApplicationController
  def index
    @franchises = Franchise.all
  end

  def show
    @franchise = Franchise.where(id: params[:id]).first
    @movies = @franchise.movies
  end
end
