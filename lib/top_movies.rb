require 'pry'
require 'rubygems'
require 'json'

class MovieCollection
  def initialize
    @whole_collection = []
  end
  
  def add_the_movie movie
    @whole_collection.push(movie)
  end

  def show_all_movies
    @whole_collection
  end

  def apply_order order
    ordered = @whole_collection.sort { |first, second| order.call(first, second) }
  end

  def apply_filter
  end

end

class Movie
  attr_accessor :title, :year, :duration, :popularity
  def initialize title, year
    @title = title
    @year = year
  end

  def set_popularity_to popularity
    @popularity = popularity
  end

  def set_duration_to duration
    @duration = duration
  end

  def has_all_attributes?
    (has_a_title?) && (has_a_year?) && (has_a_duration?) && (has_a_popularity?)
  end

  private
  def has_a_title?
    (!@title.empty?)
  end

  def has_a_year?
    (!@year.nil?)
  end

  def has_a_duration?
    (!@duration.nil?)
  end

  def has_a_popularity?
    (!@popularity.nil?)
  end
end

class Order
  def self.by(param, descendant = false)
    return lambda { |first, second| first[param] <=> second[param] } unless descendant
    lambda { |first,second| second[param] <=> first[param] }
  end
end

class Filter
  def by_duration cut_duration, delta = 12
    lambda {}
  end

  def only_fulfilled
    lambda {}
  end
end

class TopMovies

  def self.generate_top_lists(movies, filter_by_time = false, film_time = 120, delta = 12, group_by_year = false)
    grouped_movies = {}
    filtered_movies = []

    # filter the movies that does not meet the passed requirements
    movies.each { |movie| if ((movie.duration - film_time).abs < delta) then filtered_movies << movie end }
    
    # order the movies by popularity
    filtered_movies.sort! { |f, s| f.popularity <=> s.popularity }


    if group_by_year

      # filter the movies that does not meet the passed requirements
      filtered_movies_for_groups = []
      movies.each { |movie| if ((movie['duration'] - film_time).abs < delta) then filtered_movies_for_groups << movie end }

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
