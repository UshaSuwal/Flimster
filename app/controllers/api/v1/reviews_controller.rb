class Api::V1::ReviewsController < ApplicationController
  def index
    movie = Movie.find_by(mid: params[:movie_id])
    if movie
      reviews = movie.reviews.map { |review| { user_id: review.user_id, description: review.description } }
      render json: { movie_id: movie.mid, reviews_count: reviews.count ,reviews: reviews }, status: 200
    else
      # moviecreate = Tmdb::DetailService.execute(id: params[:movie_id])
      # if moviecreate
      #   Movie.create(mid: moviecreate['id'], title: moviecreate['title'], original_title: moviecreate['original_title'], overview: moviecreate['overview'], poster: moviecreate['poster_path'], status: moviecreate['status'], popularity: moviecreate['popularity'], vote_count: moviecreate['vote_count'], vote_average: moviecreate['vote_average'], budget: moviecreate['budget'], duration: moviecreate['runtime'], release_date: moviecreate['release_date'])
      #   index()
      # else
        render json: {error: "Movie not found"}, status: 404
      end
    end
  end

end
