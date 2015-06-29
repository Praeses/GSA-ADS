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

  class AgeCountImporter

    include Services::CountImporterCommon
  	attr_accessor :unsaved

  	def initialize
      @unsaved = {}
    end

    def pull filter_params={}
      url = get_url("patient.patientonsetage", filter_params)
    	get_hash(url)
    end

    def get_param_strings filter_params = {}
      param_strings=[]

      if filter_params["locations"]
        search_strings << "primarysource.reportercountry:#{filter_params["locations"]}"
      end

      if filter_params["drugs"]
        search_strings << "patient.drug.medicinalproduct:#{filter_params["drugs"]}"
      end

      param_strings
    end

    def to_csv
      csv = []
      @unsaved.each do |k, value|
        row = [('%02i' % k), value]
        csv << row.to_csv
      end
      csv.sort!
      csv = ["AGE, COUNT\n"] + csv
      csv
    end

  end
end
