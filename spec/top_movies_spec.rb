require 'top_movies'

describe "A movie" do
  it "can be told a popularity rank" do
    a_new_hope = Movie.new "Star Wars: A New Hope", 1977
    a_new_hope.set_popularity_to 100
    a_new_hope.set_duration_to 121
    expect(a_new_hope.popularity).to eq(100)
  end
end

describe "The MovieCollection" do

  before(:each) do
    @a_new_hope = Movie.new "Star Wars: A New Hope", 1977
    @a_new_hope.set_duration_to 121
    @home_collection = MovieCollection.new
  end

  it "shows all movies when is told to" do
    expect(@home_collection.show_all_movies).to eq([])
  end

  it "accepts adding movies" do
    @home_collection.add_the_movie @a_new_hope
    expect(@home_collection.show_all_movies).to eq([@a_new_hope])
  end
end

describe "The Filter" do
  it "creates a rule" do
    expect(Filter.by("length").class).to eq(Proc)
  end
end

describe TopMovies do

  context "helper methods" do

    before(:each) do
      @gigi = Movie.new "Gigi", 1958
      @gigi.set_duration_to 124
      @gigi.set_popularity_to 2
      @untitled = Movie.new "", 1983
      @untitled.set_duration_to 125
      @untitled.set_popularity_to 4
      @home = MovieCollection.new
      @home.add_the_movie @gigi
      @home.add_the_movie @untitled
    end

    it "must filter movies if they don't fit the requirements" do
      expect(TopMovies.only_fulfilled_from(@home.show_all_movies)).to eq([@gigi])
    end

  end

  context 'functionality' do

    before(:each) do
      @gigi = Movie.new "Gigi", 1958
      @gigi.set_duration_to 124
      @gigi.set_popularity_to 2
      @untitled = Movie.new "", 1983
      @untitled.set_duration_to 125
      @untitled.set_popularity_to 4
      @home = MovieCollection.new
      @home.add_the_movie @gigi
      @home.add_the_movie @untitled
    end

    it 'should order the movies by time duration' do
      ordered_movies, grouped_movies = TopMovies.generate_top_lists(home.show_all_movies, true, 120, 12)
      expect(ordered_movies.first['popularity']).to be < ordered_movies.last['popularity']
    end

    it 'should filter the movies' do
      movies = [{"id"=>54, "duration"=>124, "title"=>"Gigi", "year"=>"1958", "popularity"=>50}, {"id"=>29, "duration"=>290, "year"=>"1983", "popularity"=>1}]
      ordered_movies, grouped_movies = TopMovies.generate_top_lists(@home.show_all_movies, true, 120, 12)
      expect(ordered_movies.length).to be 1
      expect(ordered_movies.first["id"]).to be 54
    end


    it 'should group the movies' do
      movies = [{"id"=>54, "length"=>124, "title"=>"Gigi", "year"=>"1958", "popularity"=>50}, {"id"=>29, "length"=>125, "year"=>"1983", "popularity"=>1}]

      ordered_movies, grouped_movies = TopMovies.generate_top_lists(movies, true, 120, 12, true)
      expect(grouped_movies.keys).to match_array(["1958", "1983"])
    end

  end

end

