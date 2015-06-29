require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'
require './src/services/count_importer_common.rb'

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

  class LocationCountImporter

    include Services::CountImporterCommon
  	
  	attr_accessor :unsaved

  	def initialize
      @unsaved = {}
    end

    def pull filter_params={}
    	#We need to cache based on url instead of just unsaved
      url = get_url("primarysource.reportercountry.exact", filter_params)
      get_hash(url)
    end

    def get_param_strings filter_params={}
      param_strings=[]

      if filter_params["drugs"]
        param_strings << "patient.drug.medicinalproduct:#{filter_params["drugs"]}"
      end

      if filter_params["ages"]
        param_strings << "patient.patientonsetage:#{filter_params["ages"]}"
      end
      param_strings
    end

    def to_csv
      get_csv("LOCATION")
    end

  end
end