require 'test_helper'

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

  def test_search
    albums = LastFM::Album.search("Third", :limit => 5)
    assert_equal 5, albums.size
    assert_instance_of LastFM::Album, albums.first
    assert_equal "Third", albums.first.name
    assert_equal "Portishead", albums.first.artist
  end
end

