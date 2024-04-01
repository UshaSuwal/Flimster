module Tmdb
  class AllService < BaseService

      private_class_method :new
      def self.execute()
          new.execute
      end

      def execute
        url = URI("https://api.themoviedb.org/3/movie/top_rated?language=en-US&page=1")
        response = get_request(url: url)
        parsed_response = JSON.parse(response.body)
        @movies = parsed_response["results"] || [] # Ensure @movies is an array even if no results are found
      end

  end
  end
