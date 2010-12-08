$:.unshift File.expand_path('../../lib', __FILE__)
require 'logger'
require 'pp'
require 'test/unit'
require 'lastfm'

LastFM.api_key = "a6bfcaa95ef03099beee2aaf1df07e53"
#LastFM.secret = "4e33bc7469e7043fd63d485faff694f2"

LastFM.logger = Logger.new(STDOUT)
LastFM.logger.level = Logger::DEBUG

class LastFM::ArtistTest < Test::Unit::TestCase
  def test_new_with_mbid
    artist = LastFM::Artist.new(:mbid => "91f32a6b-fc11-45b6-a243-4dd90eaee781")
    assert_instance_of LastFM::Artist, artist
    
    assert_equal "Ugly Kid Joe", artist.name
    assert_equal "91f32a6b-fc11-45b6-a243-4dd90eaee781", artist.mbid
    assert !artist.image(:small).empty?, "image not found"
    assert_equal ["90s", "alternative rock", "hard rock", "metal", "rock"], artist.tags.sort
  end

  def test_new_with_artist
    artist = LastFM::Artist.new(:artist => "Dez Mona")
    assert_instance_of LastFM::Artist, artist
    
    assert_equal "Dez Mona", artist.name
    assert_nil artist.mbid
    assert !artist.image(:small).empty?, "image not found"
    assert_equal ["avant-garde", "avantgarde", "belgian",
      "belgium", "experimental"], artist.tags.sort
  end

  def test_new_failure
    assert_raise(LastFM::InvalidParameters) { LastFM::Artist.new({}).info }
    assert_raise(LastFM::InvalidParameters) { LastFM::Artist.new(:mbid => "123").info }
  end

  def test_search
    artists = LastFM::Artist.search("DAAU", :limit => 5)
  end
end

class LastFM::AlbumTest < Test::Unit::TestCase
  def test_new_with_mbid
    album = LastFM::Album.new(:mbid => "58a5c0c1-60aa-4e56-8fd5-4ee4777c9d47")
    assert_instance_of LastFM::Album, album
    
    assert_equal "10,000 Days", album.name
    assert_equal "Tool", album.artist
    assert_equal "58a5c0c1-60aa-4e56-8fd5-4ee4777c9d47", album.mbid
    assert !album.image(:small).empty?, "image not found"
    assert_equal ["albums i own", "favourite albums", "metal",
      "progressive metal", "progressive rock"], album.tags.sort
    assert_equal Date.new(2006, 5, 2), album.releasedate
  end

  def test_new_with_artist_and_album
    album = LastFM::Album.new(:artist => 'Dez Mona', :album => "Hilfe Kommt")
    assert_instance_of LastFM::Album, album
    
    assert_equal "Hilfe Kommt", album.name
    assert_equal "Dez Mona", album.artist
    assert_nil album.mbid
    assert !album.image(:small).empty?, "image not found"
    assert_equal [], album.tags.sort
    assert_equal Date.new(2009, 10, 16), album.releasedate
  end

  def test_new_failure
    assert_raise(LastFM::InvalidParameters) { LastFM::Album.new(:artist => 'Dez Mona').info }
    assert_raise(LastFM::InvalidParameters) { LastFM::Album.new(:mbid => "123").info }
  end
end

