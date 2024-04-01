class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = fetch_movie(params[:movie_id])

    @movie = Movie.find_or_create_by(mid: @movie['id'], title: @movie['title'], original_title: @movie['original_title'], overview: @movie['overview'], poster: @movie['poster_path'], popularity: @movie['popularity'])
    @review = current_user.reviews.build(review_params.merge(movie_id: @movie.id))

  if @review.save
    redirect_to movie_path(@movie.mid)
    else
    flash.now[:alert] = 'Review could not be saved.'
    render 'movies/show'
  end
  end

  private

  def fetch_movie(movie_id)
    Tmdb::DetailService.execute(id: movie_id)
  end

  def review_params
    params.require(:review).permit(:description)

  end
end
