require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'

module Services

  # ***************************************************************************************************
  # this Importer is used to pull and cache a copy of the drug event counts per location by day
  # ***************************************************************************************************

  class LocationCountsImporter

    attr_accessor :unsaved
    FIRST_DAY = Date.parse("2003-2-28")

    def initialize
      @unsaved = {}
      @locations = []
    end

    def pull location
      if @unsaved.size <= 0
        list = []
        list << location
        list.flatten!
        @locations = @locations + list

        list.each do |location|
          url = "https://api.fda.gov/drug/event.json?api_key=AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R&search=primarysource.reportercountry:#{location}&count=receivedate"
          get_data(url).each do |result|
            @unsaved[result["time"]] = {} unless @unsaved[result["time"]]
            @unsaved[result["time"]][location] = result["count"]
          end
        end
      end
      true
    end

    def get_data url
      JSON.parse(open(url).read)["results"]
    end

    def to_csv
      csv = []
     
      @unsaved.each do |k,values|
        row = [k]
        @locations.each do |location|
          row << ( values[location] || "0" )
        end
        
        csv << row.to_csv

      end
      csv.sort!
      csv = ["date," + @locations.join(",") + "\n"] + csv
      csv.join('')
    end

  end
end
