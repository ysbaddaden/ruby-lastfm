$:.unshift File.expand_path('../../lib', __FILE__)
require 'logger'
require 'pp'
require 'lastfm'

# TODO: write actual tests!

LastFM.api_key = "a6bfcaa95ef03099beee2aaf1df07e53"
#LastFM.secret = "4e33bc7469e7043fd63d485faff694f2"

LastFM.logger = Logger.new(STDOUT)
LastFM.logger.level = Logger::DEBUG

LastFM::Artist.search('ugly kid joe', :limit => 2).xpath('//artist').each do |artist|
  puts ""
  puts "  NAME: " + artist.xpath('name').text
  puts "  MBID: " + artist.xpath('mbid').text
  puts " IMAGE: " + artist.xpath("image[@size='extralarge']").text
end

LastFM::Album.search('10000 days', :limit => 2).xpath('//album').each do |album|
  puts ""
  puts "  NAME: " + album.xpath('name').text
  puts "ARTIST: " + album.xpath('artist').text
  puts "  MBID: " + album.xpath('mbid').text
  puts " IMAGE: " + album.xpath("image[@size='extralarge']").text
end

pp LastFM::Artist.new(:mbid => '91f32a6b-fc11-45b6-a243-4dd90eaee781').info.xpath('//artist/similar//name').collect(&:text)
pp LastFM::Album.new(:mbid => '58a5c0c1-60aa-4e56-8fd5-4ee4777c9d47').info.xpath('//album//track/name').collect(&:text)

pp LastFM::Artist.new(:mbid => '123').info.xpath('//artist/similar//name').collect(&:text)

