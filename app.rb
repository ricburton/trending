require 'rubygems'
require 'bundler'
require 'uri'
Bundler.require

module Trending
  # Main app's class
  class App < Sinatra::Base

    set :cache, Dalli::Client.new

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
          language.gsub!(/ |%20/, '-')
          language.downcase!
          results[language] = settings.cache.fetch(language) do
            trending = Nestful.get("https://github.com/trending?l=#{language}")
            doc = Nokogiri::HTML(trending)

            leaderboard = []
            repos = doc.css(
              'li.repo-leaderboard-list-item.leaderboard-list-item'
            )
            repos.each do |repo|
              rank         = repo.css('a.leaderboard-list-rank').text
              title_object = repo.css('h2.repo-leaderboard-title a')
              title        = title_object.text
              url          = 'http://www.github.com'
              readme       = url + title_object.first.attributes['href']
              description_check = repo.css('p.repo-leaderboard-description')

              if description_check.empty?
                description = 'No description.'
              else
                description = description_check.text
              end

              entry = { rank:        rank,
                        title:       title,
                        description: description,
                        readme:      readme }
              leaderboard << entry
            end
            settings.cache.set(language, leaderboard, 6000)
            leaderboard
          end
        end
        json(results)
      rescue Nestful::ResourceNotFound
        halt(422, json({ error: 'Trending page not found.' }))
      end
    end
  end
end
