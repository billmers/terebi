module Terebi
  class ITunes
    extend Logging

    def self.set_art(episode)

      art_path = ArtDownloader.art_path(episode.show, episode.season)
      unless File.exists?(art_path)
        logger.warn "[#{episode}] no local artwork found, skipping itunes update"
        return
      end

      command = 'osascript -e "tell application \"iTunes\" to set data of artwork 1 of (add POSIX file \"' + episode.path + '\" as alias) to (read (file POSIX file \"' + art_path +'\") as picture)"'
      result = `#{command} 2>&1`

      if result.empty?
        logger.info "[#{episode}] itunes artwork set"
        return true
      else
        logger.error "[#{episode}] failed to set itunes artwork"
        logger.error "command: #{command}"
        logger.error "result: #{result}"
        return false
      end
    end

  end
end
