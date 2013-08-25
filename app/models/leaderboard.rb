module Trending
  module Models
    # Leaderboard Model
    class Leaderboard < Sinatra::Base

      set :cache, Dalli::Client.new

      def self.fetch(languages)
        results = {}
        begin
          languages.each do |language|
            language.gsub!(/ |%20/, '-')
            language.downcase!
            results[language] = settings.cache.fetch(language) do
              trending = Nestful.get(
                "https://github.com/trending?l=#{language}"
              )
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
          results
        rescue Nestful::ResourceNotFound
          halt(422, { error: 'Trending page not found.' })
        end
      end
    end
  end
end