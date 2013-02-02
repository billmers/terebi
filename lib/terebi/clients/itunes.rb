module Terebi

  module Clients

    class ITunesClient
      def self.update_art(episode)
        episode_path = episode.file_path
        art_path = episode.art_path

        if !File.exists? art_path
          LOG.info "Skipping #{episode.to_s}, art not found."
          return
        end

        command = 'osascript -e "tell application \"iTunes\" to set data of artwork 1 of (add POSIX file \"' + episode_path + '\" as alias) to (read (file POSIX file \"' + art_path +'\") as picture)"'
        result = `#{command} 2>&1`

        if result.length == 0
          LOG.debug "iTunes art updated for #{episode.to_s}."
          return true
        else
          LOG.error "iTunes art set failed for #{episode.to_s}."
          LOG.error "command: #{command}"
          LOG.error "result: #{result}"
          return false
        end
      end
    end

  end

end

