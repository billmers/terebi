module Terebi
  class Episode
    attr_reader :full_path
    attr_reader :show_name
    attr_reader :show_dir
    attr_reader :episode_number
    attr_reader :season_number

    def initialize(full_path)
      @full_path = full_path
      file_name  = File.basename(full_path)

      @show_dir  = File.dirname(full_path)
      @show_name = File.basename(@show_dir)

      @season_number  = file_name[1..2]
      @episode_number = file_name[4..5]
    end

    def art_path()
      art = ArtDownloader.new(self)
      art.download()
      return art.build_path()
    end

    def to_s()
      "#{@show_name}: S#{@season_number} E#{@episode_number}"
    end

  end
end
