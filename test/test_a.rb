require "helper"

require "awesome_print"

require_relative "../lib/terebi/artwork"


class TestSomething < MiniTest::Unit::TestCase
  describe "iTunes store search" do

    it "has overrides" do
      artwork = Terebi::Artwork.new("test/data/config.yml")

    end
  end
end


# class TestApi < MiniTest::Unit::TestCase
#   describe "stats" do
#     before do
#       Sidekiq.redis {|c| c.flushdb }
#     end

#     describe "processed" do
#       it "is initially zero" do
#         s = Sidekiq::Stats.new
#         assert_equal 0, s.processed
#       end

#       it "returns number of processed jobs" do
#         Sidekiq.redis { |conn| conn.set("stat:processed", 5) }
#         s = Sidekiq::Stats.new
#         assert_equal 5, s.processed
#       end
#     end
#   end
# end
