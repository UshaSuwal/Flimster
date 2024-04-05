class ReviewsController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = fetch_movie(params[:movie_id])
    @moviecreate = Movie.find_by(mid: @movie['id']) || Movie.create(mid: @movie['id'], title: @movie['title'], original_title: @movie['original_title'], overview: @movie['overview'], poster: @movie['poster_path'], status: @movie['status'], popularity: @movie['popularity'], vote_count: @movie['vote_count'], vote_average: @movie['vote_average'], budget: @movie['budget'], duration: @movie['runtime'], release_date: @movie['release_date'])


    @reviewcreate = current_user.reviews.build(review_params.merge(movie_id: @moviecreate.id))

  if @reviewcreate.save
    flash.now[:alert] = 'Review success.'
    else
    flash.now[:alert] = 'Review could not be saved.'

  end
  redirect_to movie_path(id: @moviecreate.mid)
  end


  def edit
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.update(review_params)

    redirect_to movie_path(id: @movie.mid)
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to movie_path(id: @movie.mid)
  end


  private

  def fetch_movie(movie_id)
    Tmdb::DetailService.execute(id: movie_id)
  end

  def review_params
    params.require(:review).permit(:description)

  end
end
