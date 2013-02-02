# module Terebi

#   module Clients

#     class iFlicks

#     end

#   end

# end


#!/usr/bin/env ruby

# notes on AppleScript paths:
# http://www.satimage.fr/software/en/smile/external_codes/file_paths.html

file_name = ARGV.first
puts "Telling iFlicks to import #{file_name} ..."

# TODO: use spawn() and Shellwords
# TODO: import .avi files as AppleTV2 preset
# TODO: move this 'command' to a separate applescript file.
# http://appscript.sourceforge.net/osascript.html
# http://nb.nathanamy.org/2012/06/some-applescript-tips/
# http://rubycocoa.sourceforge.net/
# http://t-a-w.blogspot.com/2010/07/another-example-of-ruby-being-awesome-w.html
# system *%W[mongod --shardsvr --port #{port} --fork --dbpath #{data_dir} --logappend --logpath #{logpath} --directoryperdb]
command = 'osascript -e "tell application \"iFlicks\" to import (POSIX file \"' + file_name + '\") as QuickTime movie without gui"'
puts "Executing: " + command

if system(command)
  puts "iFlicks import successful."
  exit 0
else
  puts "iFlicks import failed."
  exit 1
end
