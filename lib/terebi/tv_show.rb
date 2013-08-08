module Terebi
  class TVShow
    attr_accessor :name
    attr_accessor :folder
    attr_accessor :episodes
    attr_accessor :seasons

    def initialize(name, folder)
      @name     = name
      @folder   = folder
      @episodes = {}
      @seasons  = Set.new

#      load_episodes
    end

    def self.create(path)
      return unless File.directory?(path)
      TVShow.new(File.basename(path), path)
    end

    def load_episodes
      Dir["#{self.folder}/*.{m4v,mp4,mov}"].each do |path|
        ep = TVEpisode.create(path, self)
        next unless ep
        @episodes[ep] = ep
        @seasons << ep.season
      end
    end

    def refresh_art
      @episodes.values.each do |ep|
        ep.refresh_art
      end
    end

    def to_s
      "#{@name} - (#{@episodes.count} episodes)"
    end
  end

end
