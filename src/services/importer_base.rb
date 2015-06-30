require 'open-uri'
require 'json'

module Services
  class ImporterBase

      def get_data url
        @cache = {} unless @cache
        return @cache[url] if @cache[url]
        @cache[url] = JSON.parse(open(url).read)["results"]
      end

  end
end
