require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'

module Services

  # ***************************************************************************************************
  # this Importer is used to pull and cache a copy of the drug event counts per location by day
  # ***************************************************************************************************

  class DrugNameImporter
  	
  	attr_accessor :unsaved

  	def initialize
      @unsaved = []
    end

    def pull
    	if @unsaved.size <= 0
	    	url = "https://api.fda.gov/drug/event.json?api_key=AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R&count=patient.drug.medicinalproduct.exact"
	    	get_data(url).each do |result|
	            @unsaved << result["term"]
	        end
    	end
    end

    def get_data url
      JSON.parse(open(url).read)["results"]
    end

    def to_csv
    	csv = @unsaved
    	csv.sort!
    	csv = @unsaved.to_csv
    	# csv = ["Name"] + csv
      	# csv.join('')
      	# binding.pry
      	csv
    end

  end
end