module Terebi
  class Library
    extend Logging

    def self.load_shows
      shows = []

      Dir.glob("#{TV_DIR}/*").each do |path|
        next unless File.directory?(path)
        show = TVShow.create(path)
        show.load_episodes
        shows << show
      end

      shows
    end

    def self.missing_art
      has_missing_art = false

      load_shows.each do |show|
        show.seasons.each do |season|
          path = ArtDownloader.art_path(show, season)
          next if File.exists?(path)
          logger.info "missing art for #{show.name} - S#{season}"
          has_missing_art = true
        end
      end

      has_missing_art
    end

    def self.refresh_all()
      load_shows.each do |show|
        show.refresh_art
      end
    end

    def self.refresh_episode(path)
      episode = TVEpisode.create(path)
      episode.refresh_art
    end

    def self.refresh_show(name)
      show = TVShow.create("#{TV_DIR}/#{name}")
      if show
        show.load_episodes
        show.refresh_art
      else
        logger.info "show not found: #{name}"
      end
    end

    def self.add_art(name, season, art_url)
      show = TVShow.create("#{TV_DIR}/#{name}")
      if show
        ArtDownloader.download(show, season, art_url)
        show.load_episodes
        show.refresh_art
      else
        logger.info "show not found: #{name}"
      end
    end

  end
end
