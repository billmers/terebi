module Terebi
  class TVEpisode
    extend Logging
    attr_accessor :number
    attr_accessor :path
    attr_accessor :season
    attr_accessor :show

    def initialize(season, number, path, show)
      @season = season.rjust(2, "0")
      @number = number.rjust(2, "0")
      @path   = path
      @show   = show
    end

    def self.create(path, show=nil)

      filename  = File.basename(path)
      unless filename =~ /^S\d{2}E\d{2}/
        logger.debug "invalid TVEpisode filename: #{filename}"
        return
      end

      season  = filename[1..2]
      number  = filename[4..5]
      show  ||= TVShow.create(File.dirname(path))

      TVEpisode.new(season, number, path, show)
    end

    def refresh_art
      ArtDownloader.search(self)
      ITunes.set_art(self)
    end

    def to_s()
      "#{@show.name} - S#{@season}E#{@number}"
    end
  end

end
