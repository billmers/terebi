require 'art_import.rb'
require 'clockwork'
include Clockwork

handler do |job|
  TVShowLibrary.update_all()
end

every(30.minutes, 'art.import')
