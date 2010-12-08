class LastFM
  class Error < StandardError
  end

  class InvalidService < Error
  end

  class InvalidMethod < Error
  end

  class AuthenticationFailed < Error
  end

  class InvalidFormat < Error
  end

  class InvalidParameters < Error
  end

  class InvalidResource < Error
  end

  class TokenError < Error
  end

  class InvalidSessionKey < Error
  end

  class InvalidAPIKey < Error
  end

  class APIKeySuspended < Error
  end

  class ServiceOffline < Error
  end

  class SubscribersOnly < Error
  end

  class InvalidMethodSignature < Error
  end

  class UnauthorizedToken < Error
  end

  class StreamingUnavailable < Error
  end

  class ServiceUnavailable < Error
  end

  class Unauthorized < Error
  end

  class TrialExpired < Error
  end

  class NotEnoughContent < Error
  end

  class NotEnoughMembers < Error
  end

  class NotEnoughFans < Error
  end

  class NotEnoughNeighours < Error
  end

  class NoPeakRadio < Error
  end

  class RadioNotFound < Error
  end

  class Deprecated < Error
  end

  protected
    @@exceptions = {
       2 => InvalidService,
       3 => InvalidMethod,
       4 => AuthenticationFailed,
       5 => InvalidFormat,
       6 => InvalidParameters,
       7 => InvalidResource,
       8 => TokenError,
       9 => InvalidSessionKey,
      10 => InvalidAPIKey,
      11 => ServiceOffline,
      12 => SubscribersOnly,
      13 => InvalidMethodSignature,
      14 => UnauthorizedToken,
      15 => StreamingUnavailable,
      16 => ServiceUnavailable,
      17 => Unauthorized,
      18 => TrialExpired,
      20 => NotEnoughContent,
      21 => NotEnoughMembers,
      22 => NotEnoughFans,
      23 => NotEnoughNeighours,
      24 => NoPeakRadio,
      25 => RadioNotFound,
      26 => APIKeySuspended,
      27 => Deprecated
    }

    def self.exception_for(xml)
      code    = xml.xpath("//error").first[:code].to_i
      message = xml.xpath("//error").text
      
      if @@exceptions[code]
        @@exceptions[code].new(message)
      else
        Error.new(message)
      end
    end
end
