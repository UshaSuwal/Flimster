module Tmdb
  class AllService < BaseService
    private_class_method :new

    def self.execute(page: nil)
      new(page).execute
    end

    def initialize(page)
      @page = page || 1
    end

    def execute
      url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=#{@page}")
      response = get_request(url: url)
      parsed_response = JSON.parse(response.body)
      movies = parsed_response["results"] || []
      pagy = Pagy.new(count: movies.count, page: @page)
      [pagy, movies]
    end
  end
end
