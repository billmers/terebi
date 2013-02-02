require "terebi/version"



# http://bendodsonapps.com/projects/itunes-tv-artwork/
# http://getvideoartwork.com/

require 'rubygems'
require 'cgi'
require 'json'
require 'logger'
require 'open-uri'

TV_DIR = "/Users/bill/Movies/TV Shows"



module Terebi
  # Your code goes here...

  STDOUT.sync = true

  LOG = Logger.new(STDOUT)
  LOG.level = Logger::INFO


end
