require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'

module Services

  # ***************************************************************************************************
  #   this Importer is used to pull and cache a copy of the drug event counts per location by day
  #   example output:
  #   DRUG
  #   ABILIFY
  #   ACETAMINOPHEN
  #   ADVAIR DISKUS 100/50
  #   ALBUTEROL
  #   ALLOPURINOL
  #   ...
  # ***************************************************************************************************

  class DrugNameImporter
  	
  	attr_accessor :unsaved

  	def initialize
      @unsaved = {}
    end

    def pull filter_params={}
    	# if @unsaved.size <= 0#We need to cache based on url instead of just unsaved
        search_string = ""
        if filter_params.count > 0
          search_string << "&search="
          param_strings=[]
          if filter_params["locations"]
            search_string << "primarysource.reportercountry:#{filter_params["locations"]}"
          end
          if filter_params["ages"]
            search_string << "patient.patientonsetage:#{filter_params["ages"]}"
          end

          search_string << param_strings.reject(&:empty?).join('+AND+')
        end
	    	url = URI::encode("https://api.fda.gov/drug/event.json?api_key=AFArTyRIont4fZLaVXQVgY2kPv8EeIj4BwD24S3R&count=patient.drug.medicinalproduct.exact"+search_string)
	    	get_data(url).each do |result|
	            @unsaved [result["term"]] = result["count"]
	        end
    	# end
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
      csv = ["DRUG, COUNT\n"] + csv
      csv
    end

  end
end