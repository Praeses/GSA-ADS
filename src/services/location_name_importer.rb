require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'

module Services

  # ***************************************************************************************************
  # this Importer is used to pull and cache a copy of all possible locations
  # example output:
  #   LOCATION
  #   "KOREA, REPUBLIC OF"
  #   ...
  #   AR
  #   ARGENTINA
  #   ...
  #   AUSTRALIA
  #   AUSTRIA
  #   BE
  #   ...
  #   COUNTRY NOT SPECIFIED
  #   CROATIA (local name: Hrvatska)
  #   CZ
  #   ...
  #   IRAN (ISLAMIC REPUBLIC OF)
  #   ...
  # ***************************************************************************************************

  class LocationNameImporter
  	
  	attr_accessor :unsaved

  	def initialize
      @unsaved = {}
    end

    def pull
    	if @unsaved.size <= 0
	    	url = "https://api.fda.gov/drug/event.json?api_key=AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R&count=primarysource.reportercountry.exact"
	    	get_data(url).each do |result|
          @unsaved [result["term"]] = result["count"]
        end
    	end
    end

    def get_data url
      JSON.parse(open(url).read)["results"]
    end

    def to_csv
      csv = []
      @unsaved.each do |k, value|
        row = [k, value]
        csv << row.to_csv
      end
      csv.sort!
      csv = ["LOCATION, COUNT\n"] + csv
      csv
    end

  end
end