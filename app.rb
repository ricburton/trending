require 'rubygems'
require 'bundler'
require 'uri'
Bundler.require

module Trending
  class App < Sinatra::Base

    helpers do
      def json(value, options = {})
         content_type :json
         value.to_json(options)
      end
    end

    get '/trending' do
      languages = params[:languages]
      results = {}
      begin
        languages.each do |language|
          language.gsub!(/ |%20/,'-')
          language.downcase!
          trending = Nestful.get("https://github.com/trending?l=#{language}")
          doc = Nokogiri::HTML(trending)

          leaderboard = []
          doc.css('div.leaderboard-list-content').each do |listing|
            rank              ||= listing.css('a.leaderboard-list-rank')
            title             ||= listing.css('h2.repo-leaderboard-title a').text
            description_check ||= listing.css('p.repo-leaderboard-description')

            description_check.empty? ? description = 'No description.' : description = description_check.text
            entry = {rank: rank, title: title, description: description}
            leaderboard << entry
          end

          results[language] = leaderboard
        end
        json(results)
      rescue Nestful::ResourceNotFound => e
        halt(422, json({error: 'Trending page not found.'}))
      end
    end
  end
end
