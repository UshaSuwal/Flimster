class Api::V1::ReviewsController < ApplicationController
    skip_before_action :verify_authenticity_token
    # before_action :authenticate_user_using_api_key, only: :create

    def index
        movie = find_movie_from_db(params[:movie_id])
        if movie
            reviews = render_reviews(movie)
            render json: { movie_id: movie.mid, review_count: reviews.count, reviews: reviews }, status: 200
        else
            tmdb_movie = fetch_tmdb(params[:movie_id])

            if tmdb_movie['id']
                create_movie_from_tmdb(tmdb_movie)
                index()
            elsif tmdb_movie['status_code'] == 6 || tmdb_movie['status_code'] == 34
                render_error()
            end
        end
    end

    def create
        movie = find_movie_from_db(params[:movie_id])

        if movie
            reviews = Review.create(review_params.merge(user_id:  User.first.id, movie_id: movie.id))
            if reviews.save
                reviews = render_reviews(movie)
                render json: { movie_id: movie.mid, reviews: reviews }, status: 201
            else
                render json: { error: "reviews not create" }, status: 404
            end
        else
            tmdb_movie = fetch_tmdb(params[:movie_id])

            if tmdb_movie['id']
                create_movie_from_tmdb(tmdb_movie)

                movie = find_movie_from_db(params[:movie_id])
                reviews = Review.create(review_params.merge(user_id: User.first.id, movie_id: movie.id))
                if reviews.save
                    reviews = render_reviews(movie)
                    render json: { movie_id: movie.mid, reviews: reviews }, status: 201
                else
                    render json: { error: "reviews not create" }, status: 404
                end
            elsif
                tmdb_movie['status_code'] == 6 || tmdb_movie['status_code'] == 34
                render_error()
            end
        end
    end

    private

    def fetch_tmdb(movie_id)
      response = Tmdb::DetailService.execute(id: movie_id)
    end

    def review_params
      params.require(:review).permit(:description)
    end

    def render_reviews(movie)
      reviews = movie.reviews.map { |review| { user_id: review.user_id, description: review.description } }
    end

    def create_movie_from_tmdb(tmdb_movie)
      Movie.create(
        mid: tmdb_movie['id'],
        title: tmdb_movie['title'],
        original_title: tmdb_movie['original_title'],
        overview: tmdb_movie['overview'],
        status: tmdb_movie['status'],
        release_date: tmdb_movie['release_date'],
        budget: tmdb_movie['budget'],
        poster: tmdb_movie['poster_path'],
        popularity: tmdb_movie['popularity'],
        duration: tmdb_movie['runtime'],
        vote_average: tmdb_movie['vote_average'],
        vote_count: tmdb_movie['vote_count']
      )
    end

    def render_error
      render json: { error: 'Movie not found' }, status: 404
    end

    def find_movie_from_db(movieId)
      Movie.find_by(mid: movieId)
    end

    # def authenticate_user_using_api_key
    #   apikey = request.headers['x-api-key']
    #   @curren = User.find_by(api_key: apikey)

    #   unless @current_user
    #     render json: { error: 'User not authenticated' }, status: :unauthorized
    #   end
    # end
  end
