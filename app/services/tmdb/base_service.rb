require 'uri'
require 'net/http'


module Tmdb
class BaseService
    API_KEY = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4OTA2Yzk3ZmYwNmEzMzQ0ZDViYjQwYjExNTc3ZjVhMSIsInN1YiI6IjY2MDY2NjRhZTFmYWVkMDE3ZGZhMWJhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1-w_Y7QqN4_G3myDA_mob8PBfC-Rh-m8ysb1Rl81wOA'
    def get_request(url:)
        http = Net::HTTP.new(url.host, url.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(url)
        request["accept"] = 'application/json'
        request["Authorization"] = "Bearer #{API_KEY}"

        response = http.request(request)
    end

end
end
