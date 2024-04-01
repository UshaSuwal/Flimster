module Tmdb
  class DetailService < BaseService
    def initialize(id)
      @id = id
    end

    private_class_method :new

    def self.execute(id:)
      new(id).execute
    end

    def execute
      url = URI("https://api.themoviedb.org/3/movie/#{@id}")


      response = get_request(url: url)
      parsed_response = JSON.parse(response.body)
      parsed_response
    end
  end
end
