module Terebi
  class ITunes
    extend Logging

    def self.update_art(episode)
      art_path     = episode.art_path
      episode_path = episode.full_path

      unless File.exists?(art_path)
        logger.warn "skipping #{episode.to_s}, art not found"
        return
      end

      command = 'osascript -e "tell application \"iTunes\" to set data of artwork 1 of (add POSIX file \"' + episode_path + '\" as alias) to (read (file POSIX file \"' + art_path +'\") as picture)"'
      result = `#{command} 2>&1`

      if result.empty?
        logger.info "art updated for #{episode.to_s}"
        return true
      else
        logger.error "failed to set art for #{episode.to_s}"
        logger.error "command: #{command}"
        logger.error "result: #{result}"
        return false
      end
    end

  end
end
