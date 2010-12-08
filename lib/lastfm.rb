require 'cgi'
require 'net/http'
require 'date'

require 'rubygems'
require 'nokogiri'

require 'lastfm/exceptions'
require 'lastfm/base'
require 'lastfm/album'
require 'lastfm/artist'

class LastFM
  def self.api_key() @@api_key end
  def self.api_key=(value) @@api_key = value end

#  def self.secret() @@secret end
#  def self.secret=(value) @@secret = value end

  def self.logger() @@logger end
  def self.logger=(value) @@logger = value end

  @@root_url = "http://ws.audioscrobbler.com/2.0/"

  protected
    # Requests the Last.fm API.
    # 
    # Raises exceptions on request failures.
    def self.request(method, params = {})
      params[:api_key] = api_key
      params[:method] = method
      
      qs = params.collect { |k,v| CGI.escape(k.to_s) + '=' + CGI.escape(v.to_s) }.join('&')
      url = @@root_url + '?' + qs
      
      logger && logger.debug? && logger.debug('LastFM: GET ' + url)
      
      response = Net::HTTP.get(URI.parse(url))
      xml = Nokogiri::XML.parse(response, url)
      
      raise exception_for(xml) if xml.xpath('//lfm').first[:status] == 'failed'
      
      xml
    end
end

