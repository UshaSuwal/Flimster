module Tmdb
  class SearchService < BaseService
      def initialize(title)
          @title = title
      end
      private_class_method :new
      def self.execute(title: )
          new(title).execute
      end



      def execute
        url = URI("https://api.themoviedb.org/3/search/movie?query=#{@title}")
        response = get_request(url: url)
        parsed_response = JSON.parse(response.body)
        @movies = parsed_response["results"] || [] # Ensure @movies is an array even if no results are found
      end

  end
  end
