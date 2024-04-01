class MoviesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_movie, only: [:new, :create]
  def index
    if params[:movie_title].present?
      @movies = Tmdb::SearchService.execute(title: params[:movie_title])
    else
      @movies = Tmdb::AllService.execute()
    end
  end


  def show
    @movie = Tmdb::DetailService.execute(id: params[:id])
  end
end
