require 'sinatra/base'
require 'uri'

class LMApi < Sinatra::Base
  configure do
    DataMapper.setup(:default, ENV['DATABASE_URL'])
    require File.dirname(__FILE__) + '/artist'
  end

  helpers do
    def lmalink(url)
      "http://archive.org#{url}"
    end
  end

  get '/' do
    haml :index
  end

  get '/artists/:artist.json' do |artist|
    Artist.first(:name => artist.downcase).to_json
  end

  get '/artists/:artist' do |artist|
    @artist = Artist.first(:name => artist.downcase)
    haml :artist
  end

  get '/artists.json' do
    response.headers['Cache-Control'] = 'public, max-age=300'

    Artist.to_json
  end
end
