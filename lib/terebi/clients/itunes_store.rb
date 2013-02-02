# module Terebi

#   module Clients

#     class CouchPotato

#     end

#   end

# end


class ArtDownloader
  attr_reader :episode

  def initialize(episode)
    @episode = episode
  end

  def download()
    art_file = build_path()
    if File.exist?(art_file)
      LOG.debug("Skipping #{@episode.to_s}, art already exists.")
      return
    end

    art_url = build_url()
    if art_url.nil?
      LOG.warn "No matches found for #{@episode.to_s}."
      return
    end

    open(art_url) do |src|
      open(art_file, "wb") do |dst|
        dst.write(src.read)
      end
    end

    LOG.info "Downloaded art for #{@episode.to_s}."
  end

  def build_path()
    "#{@episode.show_dir}/Cover Art - S#{@episode.season_number}.jpg"
  end

  # http://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html
  def build_url()
    search_term, country_code = SearchTerm.build(@episode)

    name = CGI::escape("#{search_term}")
    LOG.debug "Searching iTunes API for #{search_term}."

    itunes_url = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?country=#{country_code}&media=tvShow&entity=tvSeason&attribute=tvSeasonTerm&term=#{name}"
    LOG.debug "iTunes URL -> #{itunes_url}"

    result = JSON.parse(open(itunes_url).read())
    count = result['resultCount']

    LOG.debug "Found #{count} match(es)."
    return if count == 0

    art_url_100 = result['results'].first['artworkUrl100']
    art_url_600 = art_url_100.sub('100x100', '600x600')
    LOG.debug "First URL -> #{art_url_600}"

    art_url_600
  end
end


class SearchTerm
  def self.build(episode)
    show     = episode.show_name
    season   = episode.season_number.to_i
    iso_code = "us"

    if show.end_with? " (US)"
      show.slice! " (US)"
    end

    if show.end_with? " (UK)"
      show.slice! " (UK)"
      iso_code = "gb"
    end

    case show
    when "Downton Abbey"
      iso_code = "gb"
    when "Frozen Planet"
      iso_code = "gb"
      season = nil
    when "Homeland"
      season = season - 1 unless season == 1
    when "NOVA"
      season = "Vol. #{season-38}"
    when "Strike Back"
      season = 1
    when "The Universe"
      season = 5
    when "Human Planet", "Planet Earth", "Vietnam in HD"
      season = nil
    when "Wallander"
      season = "Series #{season}"
    when "Doctor Who (2005)"
      show = "Doctor Who"
      season = "Season #{season}"
    when "Peep Show"
      season = "Series #{season-1}"
      iso_code = "gb"
    end

    if season.nil?
      term = show
    else
      term = "#{show}, #{season}"
    end

    return term, iso_code
  end
end


