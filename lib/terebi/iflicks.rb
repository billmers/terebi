module Terebi
  class IFlicks
    include Logging

    def import_video(path)
      # notes on AppleScript paths:
      # http://www.satimage.fr/software/en/smile/external_codes/file_paths.html

      logger.info "Telling iFlicks to import #{path} ..."

      # TODO: use spawn() and Shellwords
      # TODO: move this 'command' to a separate applescript file.
      # http://appscript.sourceforge.net/osascript.html
      # http://nb.nathanamy.org/2012/06/some-applescript-tips/
      # http://rubycocoa.sourceforge.net/
      # http://t-a-w.blogspot.com/2010/07/another-example-of-ruby-being-awesome-w.html
      # system *%W[mongod --shardsvr --port #{port} --fork --dbpath #{data_dir} --logappend --logpath #{logpath} --directoryperdb]
      command = 'osascript -e "tell application \"iFlicks\" to import (POSIX file \"' + path + '\") as QuickTime movie without gui"'
      logger.info "Executing: " + command

      if system(command)
        logger.info "iFlicks import successful."
        exit 0
      else
        logger.warn "iFlicks import failed."
        exit 1
      end
    end
  end
end
