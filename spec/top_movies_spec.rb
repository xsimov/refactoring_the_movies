require 'top_movies'

describe TopMovies do
 it 'should order the movies' do
    movies = [{"id"=>54, "length"=>124, "title"=>"Gigi", "year"=>"1958", "popularity"=>50}, {"id"=>29, "length"=>125, "year"=>"1983", "popularity"=>1}]

    ordered_movies, grouped_movies = TopMovies.generate_top_lists(movies, true, 120, 12)
    expect(ordered_movies.first['popularity']).to be < ordered_movies.last['popularity']
  end


  it 'should filter the movies' do
    movies = [{"id"=>54, "length"=>124, "title"=>"Gigi", "year"=>"1958", "popularity"=>50}, {"id"=>29, "length"=>290, "year"=>"1983", "popularity"=>1}]

    ordered_movies, grouped_movies = TopMovies.generate_top_lists(movies, true, 120, 12)
    expect(ordered_movies.length).to be 1
    expect(ordered_movies.first["id"]).to be 54
  end


  it 'should group the movies' do
    movies = [{"id"=>54, "length"=>124, "title"=>"Gigi", "year"=>"1958", "popularity"=>50}, {"id"=>29, "length"=>125, "year"=>"1983", "popularity"=>1}]

    ordered_movies, grouped_movies = TopMovies.generate_top_lists(movies, true, 120, 12, true)
    expect(grouped_movies.keys).to match_array(["1958", "1983"])
  end

end

