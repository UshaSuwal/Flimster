class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :set_movie, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create

    id=@movie['id']
    puts "Movie ID IS::::: #{id}"
    puts "user ID IS::::: #{current_user.id}"
    @review = Review.create(review_params.merge(user_id: current_user.id, movie_id: id))
    if @review.save
      redirect_to @movie, notice: 'Review was successfully created.'
    else
      flash.now[:alert] = 'Review could not be saved.'
      puts @review.errors.full_messages
      redirect_to root_path
    end
  end


  private

  def review_params
    params.require(:review).permit(:description)
  end

  def set_movie
    @movie = fetch_movie(params[:movie_id])
  end

  # Method to fetch movie details from API based on movie_id
  def fetch_movie(movie_id)
    Tmdb::DetailService.execute(id: movie_id)
  end
end
