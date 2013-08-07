module Terebi
  class Library
    extend Logging

    def self.update_all()
      logger.info "refreshing all shows"

      Dir["#{TV_DIR}/**/*.*"].each do |path|
        if ['.mp4', '.m4v', '.mov'].include? File.extname(path)
          update_episode(path)
        end
      end

      logger.info "refresh finished"
    end

    def self.update_episode(path)
      episode = Episode.new(path)
      return ITunes.update_art(episode)
    end

    def self.update_show(name)
      base_dir = "#{TV_DIR}/#{name}"
      logger.info "refreshing #{name}"

      unless File.directory?(base_dir)
        logger.info "show not found: #{base_dir}"
        return
      end

      Dir["#{base_dir}/**/*.*"].each do |path|
        if ['.mp4', '.m4v', '.mov'].include? File.extname(path)
          update_episode(path)
        end
      end

      logger.info "refresh finished"
    end

  end
end
