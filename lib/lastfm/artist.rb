# Artists.
# 
# Example:
# 
#   artist = LastFM::Artist.new(:artist => "Portishead")
#   
#   <h1>
#     <%= image_tag artist.image(:small) %>
#     <%= artist.info.xpath('/artist/name').text %>
#   </h1>
#   <%= simple_format artist.info.xpath('//summary').text %>
# 
class LastFM
  class Artist < Base
    # Searches for artists.
    # 
    # Example:
    # 
    #   LastFM::Artist::Search("ugly kid joe").xpath(//artist/name).collect(&:text)
    #   # => ["Ugly Kid Joe", "Jay-Z Feat Ugly Kid Joe", ...]
    # 
    # Options:
    # 
    # - +limit+
    # - +page+
    def self.search(name, params = {})
      params[:artist] = name
      LastFM.request('artist.search', params)
    end

    attr_accessor :params

    def initialize(options)
      self.params = {}
      
      if options[:mbid]
        self.params[:mbid] = options[:mbid]
      else
        self.params[:artist] = options[:artist]
      end
    end

    def info
      @info ||= LastFM.request('artist.getInfo', params)
    end

    def image(format = :extralarge)
      info.xpath("/artist/image[@size='" + format.to_s + "']").text
    end
  end
end

