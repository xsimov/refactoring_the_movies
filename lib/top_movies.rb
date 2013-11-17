require 'rubygems'
require 'json'

class TopMovies
  def self.generate_top_lists(movies, filter_by_time = false, film_time = 120, delta = 12, group_by_year = false)
    grouped_movies = {}
    filtered_movies = []

    # filter the movies that does not meet the passed requirements
    movies.each { |movie| if ((movie['length'] - film_time).abs < delta) then filtered_movies << movie end }
    
    # order the movies by popularity
    filtered_movies.each_index do |i|
      (filtered_movies.length - i - 1).times do |job|
        if filtered_movies[job]['popularity'] > filtered_movies[job + 1]['popularity']
          filtered_movies[job], filtered_movies[job + 1] = filtered_movies[job + 1], filtered_movies[job]
        end
      end
    end


    if group_by_year
      # filter the movies that does not meet the passed requirements
      filtered_movies_for_groups = []
      movies.each { |movie| if ((movie['length'] - film_time).abs < delta) then filtered_movies_for_groups << movie end }

      # we group the movies by year
      filtered_movies_for_groups.each do |movie|
        grouped_movies[movie['year']] ||= []
        grouped_movies[movie['year']] << movie
      end

      # we order each group 
      grouped_movies.each do |year, movies|
        movies.each_index do |i|
          (movies.length - i - 1).times do |job|
            if movies[job]['popularity'] > movies[job + 1]['popularity']
              movies[job], movies[job + 1] = movies[job + 1], movies[job]
            end
          end
        end
      end
    end

    [filtered_movies, grouped_movies]
  end
end
