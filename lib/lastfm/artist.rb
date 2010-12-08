# Artists.
# 
# Example:
# 
#   artist = LastFM::Artist.new(:artist => "Portishead")
#   
#   <h1>
#     <%= image_tag artist.image(:small) %>
#     <%= artist.name %>
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
      LastFM.request('artist.search', params).xpath("//artistmatches/artist").each do |artist|
        
      end
    end

    def initialize(options)
      self.params = {}
      
      if options[:mbid]
        self.params[:mbid] = options[:mbid]
      else
        self.params[:artist] = options[:artist]
      end
    end

    def tags
      info.xpath('//tags/tag/name').collect(&:text)
    end
  end
end

