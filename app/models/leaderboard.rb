module Trending
  module Models
    # Leaderboard Model
    class Leaderboard < Sinatra::Base

      set :cache, Dalli::Client.new

      def self.fetch(languages)
        results = {}
        begin
          languages.each do |language|
						puts(language)
            language.gsub!(/ |%20/, '-')
            language.downcase!
            results[language] = settings.cache.fetch(language) do
              trending = Nestful.get(
                "https://github.com/trending?l=#{language}"
              )
							puts("https://github.com/trending?l=#{language}")
              doc = Nokogiri::HTML(trending)

              leaderboard = []
              repos = doc.css(
                'li.repo-list-item'
              )
              repos.each do |repo|
                rank         = repo.css('a.leaderboard-list-rank').text
                title_object = repo.css('h3.repo-list-name a')
                title        = title_object.text
                url          = 'http://www.github.com'
                repo_url     = url + title_object.first.attributes['href']
                description_check = repo.css('p.repo-leaderboard-description')

                if description_check.empty?
                  description = 'No description.'
                else
                  description = description_check.text
                end

                entry = { rank:        rank,
                          title:       title,
                          description: description,
                          repo_url:    repo_url }
                leaderboard << entry
              end
              settings.cache.set(language, leaderboard, 6000)
              p leaderboard
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
