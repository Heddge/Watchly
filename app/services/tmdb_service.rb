
require "net/http"
require "json"

class TmdbService
  BASE_URL = "https://api.themoviedb.org/3"

  def self.top_rated_movies(page: 1)
    uri = URI("#{BASE_URL}/movie/top_rated")
    uri.query = URI.encode_www_form(
      api_key: ENV.fetch("TMDB_API_KEY"),
      language: "en-US",
      page: page
    )

    response = Net::HTTP.get_response(uri)
    unless response.is_a?(Net::HTTPSuccess)
      raise "TMDB API error: HTTP #{response.code}"
    end

    JSON.parse(response.body).fetch("results")
  end
end
