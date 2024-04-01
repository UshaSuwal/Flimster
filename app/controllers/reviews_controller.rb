class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def new

  end

  def create
    @movie = fetch_movie(params[:movie_id])
    puts "Movie HASH: #{@movie}"



    @review = Review.create(review_params.merge(user_id: current_user.id , movie_id: @movie['id']))
    @review.save
    if @review.save
      redirect_to root_path, notice: 'Review was successfully created.'   #movie_path(params[:movie_id])
    else
      flash.now[:alert] = 'Review could not be saved.'
      redirect_to @movie
    end
  end

  private

  def review_params
    params.require(:review).permit(:description)
  end

  # Method to fetch movie details from API based on movie_id
  def fetch_movie(movie_id)
    @movie = Tmdb::DetailService.execute(id: params[:movie_id])
  end
end
