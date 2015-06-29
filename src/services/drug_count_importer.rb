require 'open-uri'
require 'json'
require 'pry'
require 'csv'
require 'fileutils'
require './src/services/count_importer_common.rb'

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

  class DrugCountImporter

    include Services::CountImporterCommon
  	attr_accessor :unsaved

  	def initialize
      @unsaved = {}
    end

    def pull filter_params={}
    	# if @unsaved.size <= 0#We need to cache based on url instead of just unsaved
      url=get_url("patient.drug.medicinalproduct.exact", filter_params)
    	get_hash(url)
    	# end
    end

    def get_param_strings filter_params = {}
      
      param_strings=[]

      if filter_params["locations"]
        param_strings << "primarysource.reportercountry:#{filter_params["locations"]}"
      end

      if filter_params["ages"]
        param_strings << "patient.patientonsetage:#{filter_params["ages"]}"
      end

      param_strings
    end
    def to_csv
      get_csv("DRUG")
    end

  end
end
