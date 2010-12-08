require 'test_helper'

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
    assert_equal 5, artists.size
    assert_instance_of LastFM::Artist, artists.first
    assert_equal "DAAU", artists.first.name
  end
end

