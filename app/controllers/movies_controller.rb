class MoviesController < ApplicationController
  before_action :authenticate_user!
  # before_action :set_movie, only: [:new, :create]
  def index
    if params[:movie_title].present?
      @movies = Tmdb::SearchService.execute(title: params[:movie_title])
    else
      @movies = Tmdb::AllService.execute()
    end
  end


  def show
    @movie = Tmdb::DetailService.execute(id: params[:id])
  end



  def create
    @movie = fetch_movie(params[:movie_id])

    id = @movie['id']

    
    existing_movie = Movie.find_by(mid: id)

    if existing_movie
      redirect_to movie_path(existing_movie.mid), notice: 'Movie already exists in the database.'
    else
      @movie = Movie.create(mid: id, title: @movie['title'], original_title: @movie['original_title'], overview: @movie['overview'], poster: @movie['poster_path'], popularity: @movie['popularity'])

      if @movie.save
        redirect_to movie_path(@movie['mid']), notice: 'Movie was successfully created.'
      else
        flash.now[:alert] = 'Movie could not be saved.'
        redirect_to root_path
      end
    end
  end


  def fetch_movie(movie_id)
    Tmdb::DetailService.execute(id: movie_id)
  end

end
