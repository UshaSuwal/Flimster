class Api::V1::ReviewsController < ApplicationController
    def index
        movie = Movie.find_by(mid: params[:movie_id])
        if movie
        reviews = movie.reviews.map { |review| { user_id: review.user_id, description: review.description } }
        render json: { movie_id: movie.mid, review_count: reviews.count, reviews: reviews }

        else
        tmdb_movie = fetch_tmdb(params[:movie_id])

            if tmdb_movie['id']
                Movie.create(
                mid: tmdb_movie['id'],
                title: tmdb_movie['title'],
                original_title: tmdb_movie['original_title'],
                overview: tmdb_movie['overview'],
                status: tmdb_movie['status'],
                release_date: tmdb_movie['release_date'],
                budget: tmdb_movie['budget'],
                poster: tmdb_movie['poster_path'],
                popularity: tmdb_movie['popularity']
                )
                index()
            elsif tmdb_movie['status_code']== 6 || tmdb_movie['status_code']== 34
                render json: { error: 'Movie not found' }, status: 404
            end
        end

    end

    private

    def fetch_tmdb(movie_id)
      response = Tmdb::DetailService.execute(id: movie_id)
    end
  end
