
class TmdbMovieImporter
  def self.import_top_rated(limit: 50)
    imported = 0
    skipped = 0

    pages_needed = (limit.to_f / 20).ceil

    (1..pages_needed).each do |page|
      TmdbService.top_rated_movies(page: page).each do |movie|
        break if imported + skipped >= limit

        release_date = movie["release_date"].to_s
        release_year = release_date[0, 4].to_i

        if movie["id"].blank? ||
           movie["title"].blank? ||
           release_year <= 1800 ||
           release_year > Date.current.year
          skipped += 1
          next
        end

        item = Item.find_or_initialize_by(tmdb_id: movie["id"])

        item.assign_attributes(
          title: movie["title"],
          description: movie["overview"].to_s,
          item_type: "movie",
          release_year: release_year,
          poster_path: movie["poster_path"],
          tmdb_rating: movie["vote_average"]
        )

        if item.save
          imported += 1
        else
          skipped += 1
          puts "Skipped #{movie['title']}: #{item.errors.full_messages.join(', ')}"
        end
      end

      break if imported + skipped >= limit
    end

    puts "Imported or updated: #{imported}"
    puts "Skipped: #{skipped}"
  end
end
