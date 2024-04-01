class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = fetch_movie(params[:movie_id])



    @moviecreate = Movie.find_by(mid: @movie['id']) || Movie.create(mid: @movie['id'], title: @movie['title'], original_title: @movie['original_title'], overview: @movie['overview'], poster: @movie['poster_path'], popularity: @movie['popularity'])
    
    @reviewcreate = current_user.reviews.build(review_params.merge(movie_id: @moviecreate.id))

  if @reviewcreate.save
    flash.now[:alert] = 'Review success.'
    else
    flash.now[:alert] = 'Review could not be saved.'

  end
  redirect_to movie_path(id: @moviecreate.mid)
  end






  private

  def fetch_movie(movie_id)
    Tmdb::DetailService.execute(id: movie_id)
  end

  def review_params
    params.require(:review).permit(:description)

  end
end
