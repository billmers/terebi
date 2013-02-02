#!/Users/bill/.rbenv/versions/1.9.3-p327/bin/ruby

require 'rubygems'
require 'listen'
require 'logger'
require_relative 'art_import'

# TV_DIR = "/Users/bill/Movies/TV Shows"
# LOG = Logger.new(STDOUT)
# LOG.level = Logger::DEBUG

LOG.info 'Watcher started.'

Listen.to(TV_DIR, :latency => 0.5) do |modified, added, removed|
  LOG.debug "got event"

  removed.each do |path|
    LOG.debug "removed: #{path}"

    if ['.mp4', '.m4v', '.mov'].include? File.extname(path)
      tmp_part = path.chomp(File.extname(path))

      if File.extname(tmp_part).start_with? '.tmp-'
        path = tmp_part.chomp(File.extname(tmp_part)) + File.extname(path)
        LOG.info "updating file - #{path}"
        sleep(5)

        TVShowLibrary.update_episode(path)
        LOG.debug "completed file - #{path}"
      else
        LOG.debug "ignoring non-temporary file - #{path}"
      end
    end
  end

  # added.each do |path|
  #   LOG.debug "added: #{path}"

  #   if ['.mp4', '.m4v', '.mov'].include? File.extname(path)
  #     path_without_extension = path.chomp(File.extname(path))

  #     if File.extname(path_without_extension).start_with? '.tmp-'
  #       LOG.info "ignoring temporary file - #{path}"
  #     else
  #       LOG.info "updating file - #{path}"
  #       sleep(5)

  #       TVShowLibrary.update_episode(path)
  #       LOG.debug "completed file - #{path}"
  #     end
  #   end
  # end
end

LOG.info 'Watcher done.'
