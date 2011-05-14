load 'app.rb'
require 'test/unit'
require 'rack/test'

class LMApiTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    LMApi
  end

  def test_index
    get '/'

    assert_match "http://www.archive.org/details/etree", last_response.body, "expected link to LMA"
    assert_match "Jeffrey Chupp", last_response.body, "expected branding"
    assert_match /semanticart/, last_response.body, "expected branding"
  end

  def test_artist_json
    # ignores case
    ['Pinback', 'pINBacK'].each do |artist|
      get "/artists/#{artist}.json"

      json = JSON.parse(last_response.body)
      assert_equal '/details/Pinback', json['details_link']
      assert_equal '/search.php?query=collection%3APinback', json['shows_link']
      assert json['show_count'].to_i > 0, "expected to find more than 0 shows"
    end
  end

  def test_artist
    get '/artists/Pinback'

    assert_match 'http://archive.org/details/Pinback', last_response.body
    assert_match 'http://archive.org/search.php?query=collection%3APinback', last_response.body
  end

  def test_all_artists_json
    get '/artists.json'

    assert_equal Artist.to_json, last_response.body
  end
end
