require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'
require './src/services/name_importer_common.rb'

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

    include Services::NameImporterCommon
  	
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
      get_csv("DRUG")
    end

  end
end