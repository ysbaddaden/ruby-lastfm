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
      response = LastFM.request('artist.search', params)
      response.xpath("//artistmatches/artist").collect { |artist| new(:info => artist) }
    end

    def initialize(options)
      if options[:info]
        self.info = options[:info]
      else
        self.params = {}
        
        if options[:mbid]
          self.params[:mbid] = options[:mbid]
        else
          self.params[:artist] = options[:artist]
        end
      end
    end

    def tags
      info.xpath('//tags/tag/name').collect(&:text)
    end
  end
end

