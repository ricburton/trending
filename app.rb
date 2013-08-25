require 'rubygems'
require 'bundler'
require 'uri'
Bundler.require

$LOAD_PATH << File.expand_path('../', __FILE__)
set :root, File.dirname(__FILE__)

require 'app/models'

module Trending
  # Main app's class
  class App < Sinatra::Base
    helpers do
      def json(value)
        content_type :json
        JSON.pretty_generate(value)
      end
    end

    get '/trending' do
      json(Models::Leaderboard.fetch(params[:languages]))
    end
  end
end

include Trending::Models