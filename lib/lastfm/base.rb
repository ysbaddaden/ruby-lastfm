class LastFM
  class Base
    attr_accessor :params
    attr_writer :info

    def info
      @info ||= LastFM.request(class_name + '.getInfo', params)
    end

    def name
      text('name')
    end

    def url
      text('url')
    end

    def mbid
      text('mbid')
    end

    def image(format = :extralarge)
      text("image[size='" + format.to_s + "']")
    end

    protected
      def class_name
        @class_name ||= self.class.name.split('::').last.downcase
      end

      def node(name)
        info.css(class_name + " " + name).first || info.css(name).first
      end

      def text(name)
        text = node(name).text
        text unless text.empty?
      end
  end
end

