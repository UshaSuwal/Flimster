require 'pagy'

module Tmdb
  class SearchService < BaseService
    def initialize(title, page)
      @title = title
      @page = page || 1
    end

    private_class_method :new

    def self.execute(title:, page: nil)
      new(title, page).execute
    end

    def execute
      url = URI("https://api.themoviedb.org/3/search/movie?query=#{@title}&page=#{@page}")
      response = get_request(url: url)
      parsed_response = JSON.parse(response.body)
      movies = parsed_response["results"] || []
      pagy = Pagy.new(count: movies.count, page: @page)
      [pagy, movies]
    end
  end
end
