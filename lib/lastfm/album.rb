# Albums.
# 
# Example:
# 
#   album = LastFM::Album.new(:artist => "Portishead", :album => "Third")
#   
#   <h1>
#     <%= image_tag album.image(:small) %>
#     <%= album.name %>
#     (<%= album.artist %>)
#   </h1>
#   <%= simple_format album.info.xpath('//summary').text %>
# 
class LastFM
  class Album < Base
    # Searches for albums.
    # 
    # Example:
    # 
    #   LastFM::Album::Search("10000 days", :artist => 'tool').xpath(//album/name).collect(&:text)
    #   # => ["10,000 Days", "10000 Days", ...]
    # 
    # Options:
    # 
    # - +artist+
    # - +limit+
    # - +page+
    def self.search(album, options = {})
      params = { :album => album }
      params[:limit]  = options[:limit] if options[:limit]
      params[:page]   = options[:page]  if options[:page]
      LastFM.request('album.search', params)
    end

    def initialize(options)
      self.params = {}
      
      if options[:mbid]
        self.params[:mbid] = options[:mbid]
      else
        self.params[:artist] = options[:artist]
        self.params[:album] = options[:album]
      end
    end

    def artist
      text('artist')
    end

    def tags
      info.xpath('//toptags/tag/name').collect(&:text)
    end

    def releasedate
      date = text('releasedate')
      Date.parse(date) if date
    end
  end
end

