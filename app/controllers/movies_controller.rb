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
    puts "Movie Hash #{@movie}"
    id=@movie['id']
    puts "Movie ID IS::::: #{id}"
    puts "user ID IS::::: #{current_user.id}"
    @movie = Movie.create(mid: id ,title: @movie['title'], original_title: @movie['original_title'] , overview: @movie['overview'] , poster: @movie['poster_path'] , popularity: @movie['popularity'] )
    if @movie.save
      redirect_to @movie, notice: 'Review was successfully created.'
    else
      flash.now[:alert] = 'Review could not be saved.'

      redirect_to root_path
    end

  end

  # def set_movie
  #   @movie = fetch_movie(params[:movie_id])
  # end

  # Method to fetch movie details from API based on movie_id
  def fetch_movie(movie_id)
    Tmdb::DetailService.execute(id: movie_id)
  end

end
