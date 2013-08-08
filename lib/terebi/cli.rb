$stdout.sync = true

require 'thor'
require 'terebi'

module Terebi
  class CLI < Thor
    include Logging

    desc "add-art NAME SEASON URL", "Add artwork to a TV show"
    def add_art(name, season, url)
      Library.add_art(name, season, url)
    end

    desc "cleanup-library", "Archive or delete watched videos"
    def cleanup_library
      puts "not implemented"
    end

    desc "diff-library", "Show differences between the filesystem and iTunes"
    def diff_library
      puts "not implemented"
    end

    desc "import-video PATH", "Tell iFlicks to import a video"
    def import_video(path)
      IFlicks.new.import_video(path)
    end

    desc "missing-art", "List TV shows that are missing artwork"
    def missing_art
      if Library.missing_art()
        logger.info ""
        logger.info "try"
        logger.info "  http://squaredtvart.tumblr.com/"
        logger.info "  http://bendodsonapps.com/projects/itunes-artwork-finder/"
        logger.info "  http://getvideoartwork.com/"
      else
        logger.info "no missing artwork"
      end
    end

    # option :days,  :aliases => "d", :banner => "N",     :desc => "only refresh shows modified in the last N days"

    desc "refresh-all", "Refresh artwork for all shows"
    def refresh_all
      Library.refresh_all
    end

    desc "refresh-episode PATH", "Refresh artwork for an episode"
    def refresh_episode(path)
      Library.refresh_episode(path)
    end

    desc "refresh-show NAME", "Refresh artwork for a show"
    def refresh_show(name)
      Library.refresh_show(name)
    end

    desc "scan-movie FOLDER", "Tell CouchPotato to process a movie folder"
    def scan_movie(folder)
      CouchPotato.new.scan(folder)
    end

  end
end
