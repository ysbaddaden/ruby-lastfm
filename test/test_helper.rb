$:.unshift File.expand_path('../../lib', __FILE__)
require 'logger'
require 'test/unit'
require 'lastfm'

LastFM.api_key = "a6bfcaa95ef03099beee2aaf1df07e53"
#LastFM.secret = "4e33bc7469e7043fd63d485faff694f2"

LastFM.logger = Logger.new(STDOUT)
LastFM.logger.level = Logger::DEBUG

