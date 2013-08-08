require 'cgi'
require 'json'
require 'open-uri'

module Terebi

  class ArtDownloader
    extend Logging
    ITUNES_URL = "https://itunes.apple.com/search?media=tvShow&entity=tvSeason&attribute=tvSeasonTerm"

    def self.art_path(show, season)
      "#{show.folder}/S#{season} - Cover Art.jpg"
    end

    def self.download(show, season, art_url)
      season = season.rjust(2, "0")
      art_path = art_path(show, season)

      open(art_url) do |src|
        open(art_path, "wb") do |dst|
          dst.write(src.read)
        end
      end

      logger.info "[#{show.name} - S#{season}] downloaded artwork"
    end

    def self.search(episode)
      art_path = art_path(episode.show, episode.season)
      return if File.exist?(art_path)

      art_url = build_url(episode)
      if art_url.nil?
        logger.warn "[#{episode}] no artwork found on itunes store"
        return
      end

      download(episode.show, episode.season, art_url)
    end

    def self.build_url(episode)

      criteria = self.build_search_criteria(episode)
      criteria.each do |criterion|

        term = criterion[:term]
        country = criterion[:country]
        logger.info "[#{episode}] searching itunes store for artwork (term=#{term}, country=#{country})"

        search_url = "#{ITUNES_URL}&country=#{country}&term=#{CGI::escape(term)}"
        logger.debug "[#{episode}] search url: #{search_url}"

        result = JSON.parse(open(search_url).read())
        count = result['resultCount']

        logger.debug "[#{episode}] found #{count} match(es)"
        next if count == 0

        art_url_100 = result['results'].first['artworkUrl100']
        art_url_600 = art_url_100.sub('100x100', '600x600')
        logger.debug "[#{episode}] art url: #{art_url_600}"

        return art_url_600
      end

      return
    end

    def self.build_search_criteria(episode)
      name   = episode.show.name
      season = episode.season.to_i

      if name.end_with?("(UK)")
        country1 = "gb"
        country2 = "us"
      else
        country1 = "us"
        country2 = "gb"
      end

      # remove (YYYY), (UK), and (US) suffixes from the show name
      name.sub!(/ \((\d{4}|UK|US)\)$/, "")

      criteria = []
      criteria << {term: "#{name} #{season}", country: country1}
      criteria << {term: name, country: country1}
      criteria << {term: "#{name} #{season}", country: country2}
      criteria << {term: name, country: country2}

      criteria
    end

  end
end
