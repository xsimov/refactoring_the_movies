$:.unshift(File.join(File.dirname(__FILE__), "lib"))
puts $:
require 'top_movies'

task :default => :generate_top_lists

desc 'Generates top lists of the most popular films'
task :generate_top_lists do
  source_path = 'data/movies.json'
  ordered_films_path   = 'data/ordered_movies.json'
  grouped_films_path   = 'data/grouped_ordered_movies.json'

  film_time = 120
  delta = 12

  source_file = File.open(source_path)
  movies      = JSON.load(source_file)
  unless movies.nil?
    
    ordered_movies, grouped_movies = TopMovies.generate_top_lists(movies, true, film_time, delta, true)

    File.open(grouped_films_path, 'w+') { |f| f.write(JSON.pretty_generate(grouped_movies)) }
    File.open(ordered_films_path, 'w+') { |f| f.write(JSON.pretty_generate(ordered_movies)) }

    File.truncate(source_path, 0)
  else
    source_file.close
  end

end