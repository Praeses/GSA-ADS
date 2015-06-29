require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'
require './src/services/count_importer_common.rb'

module Services

  # ***************************************************************************************************
  # this Importer is used to pull and cache a copy of the drug event counts per location by day
  # ***************************************************************************************************

  class LocationCountsImporter

    attr_accessor :unsaved
    FIRST_DAY = Date.parse("2003-2-28")
    include Services::CountImporterCommon

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
          get_hash(url, location)
        end
      end
      true
    end

    def to_csv
      csv = get_csv(@locations, "LOCATION")
      csv
    end

  end
end
