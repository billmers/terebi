#!/usr/bin/env ruby

require 'rubygems'
require 'cgi'
require 'json'
require 'open-uri'

tv_dir = "/Users/bill/Movies/TV Shows/"
art_dir =  "/Users/bill/Movies/Artwork/"

# http://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html
def build_art_url(search_term)
  name = CGI::escape("#{search_term}")
#  puts "Searching iTunes API for #{show}, #{series}."

  itunes_url = "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?country=us&media=tvShow&entity=tvSeason&attribute=tvSeasonTerm&term=#{name}"
#  puts "iTunes URL -> #{itunes_url}"

  result = JSON.parse(open(itunes_url).read())
  count = result['resultCount']
#  puts "Found #{count} match(es)."

  return if count == 0

  art_url_100 = result['results'].first['artworkUrl100']
  art_url_600 = art_url_100.sub('100x100', '600x600')
#  puts "First URL -> #{art_url_600}"

  art_url_600
end

def translate_args(show, season)

  case show
  when "NOVA"
    term = "NOVA, Vol. #{season-38}"
  when "Homeland", "Downton Abbey"
    term = "#{show}, Season #{season-1}"
  when "Vietnam in HD", "Frozen Planet", "Planet Earth", "Human Planet"
    term = show
  when "Wilfred (US)"
    term = "Wilfred, #{season}"
  else
    term = "#{show}, #{season}"
  end

  term
end

#  set data of artwork 1 of (add POSIX file "/Users/bill/Movies/TV Shows/Breaking Bad/S05E02 - Madrigal.m4v" as alias) to (read (file POSIX file "/Users/bill/Movies/TV Shows/Breaking Bad/art-s05-600x600.jpg") as picture)

def apply_art(path, season, file)
    seasons = Dir["#{path}/S#{season}*.*"].each do |ep|
      puts "..applying art to #{ep}"


#command = 'osascript -e "tell application \"iFlicks\" to import (POSIX file \"' + file_name + '\") as QuickTime movie without gui"'


command = 'osascript -e "tell application \"iTunes\" to set data of artwork 1 of (add POSIX file \"' + ep + '\" as alias) to (read (file POSIX file \"' + file +'\") as picture)"'

#puts "Executing: " + command

if system(command)
  puts "iTunes art set ok."
else
  puts "iTunes art set FAILED."
end


      # ep = ep.gsub("'", "\'")
      # `osascript -e 'tell application "iTunes" to set data of artwork 1 of (add POSIX file "#{ep}" as alias) to (read (file POSIX file "#{file}") as picture)'`

    end

end

#url = build_art_url("Nova", "Vol. 7")

Dir["#{tv_dir}*"].each do |path|

  show = File.basename(path)
#  puts show

  seasons = Dir["#{path}/S*.*"].collect { |episode| File.basename(episode)[1..2].to_i }
  seasons.uniq!

  next if seasons.length == 0

#  puts show + " " + seasons.uniq.join

  seasons.each do |season|

    art_file = "#{path}/art-s#{season.to_s.rjust(2, '0')}-600x600.jpg"
#puts art_file

    if File.exists? art_file
      apply_art(path, season.to_s.rjust(2, '0'), art_file )
      next
    end

    term = translate_args(show, season)
    puts term
    art_url = build_art_url(term)
    next if art_url.nil?


    #open("somefile.zip","wb").write(open("ftp://username:password@host:port/remotefile.zip", :proxy=>"http://proxyhost:proxyport").read)


    open(art_url) do |src|
      open(art_file, "wb") do |dst|
        dst.write(src.read)
      end
    end

    puts "art written"


  end

end
