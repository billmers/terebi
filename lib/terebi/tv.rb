
class TVEpisode
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
    "#{@show_name} - S#{@season_number} E#{@episode_number}"
  end
end

class TVShowLibrary
  def self.update_episode(path)
    episode = TVEpisode.new(path)
    return ITunesClient.update_art(episode)
  end

  def self.update_show(name)
    LOG.info "Starting TV Show library art update."

    Dir["#{TV_DIR}/#{name}/**/*.*"].each do |path|
      puts path
      if ['.mp4', '.m4v', '.mov'].include? File.extname(path)
        update_episode(path)
      end
    end

    LOG.info "Finished updating library."
  end

  def self.update_all()
    LOG.info "Starting TV Show library art update."

    Dir["#{TV_DIR}/**/*.*"].each do |path|
      if ['.mp4', '.m4v', '.mov'].include? File.extname(path)
        update_episode(path)
      end
    end

    LOG.info "Finished updating library."
  end
end
