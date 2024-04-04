class Api::V1::MovieReviewsController < ApplicationController
  def index
    reviews = Review.all
    render json: reviews.as_json(except: [:id, :created_at, :updated_at, :movie_id]), status: 200
  end

  def show
    puts "params::::::::::::::::::::::: #{params}"
  movie = Movie.find_by(mid: params[:mid])
    if movie.present?
      redirect_to api_v1_movie_review_path(movie.id)
    else
      render json: { error: "Not found janab" }, status: 404
    end
  end
end























# class Api::V1::MovieReviewsController < ApplicationController
#   def index
#     reviews = Review.all
#     render json: reviews.as_json(except: [:id, :created_at, :updated_at, :movie_id]), status: 200
#   end

#   def show
#     puts "params::::::::::::::::::::::: #{params}"
#     movie = Movie.find_by(mid: params[:mid])
#     if movie.present?
#       review = Review.where(movie_id: movie.id)
#       render json: review.as_json(except: [:id, :created_at, :updated_at, :movie_id]), status: 200
#     else
#       render json: { error: "Not found janab" }, status: 404
#     end
#   end
# end
