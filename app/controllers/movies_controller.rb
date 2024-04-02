class MoviesController < ApplicationController
  # before_action :authenticate_user!
  # before_action :set_movie, only: [:new, :create]
  def index
    if params[:movie_title].present?
      @pagy, @movies = Tmdb::SearchService.execute(title: params[:movie_title], page: params[:page])
    else
      @pagy, @movies = Tmdb::AllService.execute(page: params[:page])
    end
  end


  def show
    @movie=Movie.find_by(mid: params[:id])
    if @movie.nil?
      @moviecreate = Tmdb::DetailService.execute(id: params[:id])
    end
  end


end
